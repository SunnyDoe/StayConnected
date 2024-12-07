import UIKit
import Combine

class HomePageViewController: UIViewController {
    
    private let questionLbl: UILabel = {
        let label = UILabel()
        label.text = "Questions"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let generalButton: UIButton = {
        let button = UIButton()
        button.setTitle("General", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    private let personalButton: UIButton = {
        let button = UIButton()
        button.setTitle("Personal", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    private let noQuestionsLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No questions available"
        return label
    }()
    
    private let firstToAskLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Be the first to ask a question!"
        return label
    }()
    
    private let ifEmptyImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "IfEmpty"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(QuestionCell.self, forCellReuseIdentifier: "QuestionCell")
        return tableView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        tableView.separatorStyle = .none
        
        
        setupButtonActions()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIForQuestions()
        bindViewModel()
    }
    
    private func setupUI() {
        view.addSubview(questionLbl)
        view.addSubview(addButton)
        view.addSubview(buttonStackView)
        view.addSubview(noQuestionsLbl)
        view.addSubview(firstToAskLbl)
        view.addSubview(ifEmptyImage)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(QuestionCell.self, forCellReuseIdentifier: "QuestionCell")
        
        
        buttonStackView.addArrangedSubview(generalButton)
        buttonStackView.addArrangedSubview(personalButton)
        
        updateButtonStyles(activeButton: generalButton)
        
        
        NSLayoutConstraint.activate([
            questionLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            questionLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            buttonStackView.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            buttonStackView.heightAnchor.constraint(equalToConstant: 39),
            
            noQuestionsLbl.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 30),
            noQuestionsLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstToAskLbl.topAnchor.constraint(equalTo: noQuestionsLbl.bottomAnchor, constant: 13),
            firstToAskLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ifEmptyImage.topAnchor.constraint(equalTo: firstToAskLbl.bottomAnchor, constant: 19),
            ifEmptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupButtonActions() {
        generalButton.addTarget(self, action: #selector(generalButtonTapped), for: .touchUpInside)
        personalButton.addTarget(self, action: #selector(personalButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func generalButtonTapped() {
        viewModel.switchQuestionType(to: .general)
    }
    
    @objc private func personalButtonTapped() {
        viewModel.switchQuestionType(to: .personal)
    }
    
    @objc private func addButtonTapped() {
        let addQuestionVC = AddQuestionViewController()
        addQuestionVC.delegate = self
        present(addQuestionVC, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.$currentQuestionType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] questionType in
                guard let self = self else { return }
                
                self.noQuestionsLbl.isHidden = false
                self.firstToAskLbl.isHidden = false
                
                let activeButton = questionType == .general ? self.generalButton : self.personalButton
                self.updateButtonStyles(activeButton: activeButton)
                
                switch questionType {
                case .general:
                    self.noQuestionsLbl.text = "No questions yet"
                    self.firstToAskLbl.text = "Be the first to ask one"
                case .personal:
                    self.noQuestionsLbl.text = "Got a question in mind?"
                    self.firstToAskLbl.text = "Ask it and wait for like-minded people to answer"
                }
                
                self.view.layoutIfNeeded()
            }
            .store(in: &cancellables)
        
        viewModel.$isQuestionsEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEmpty in
                guard let self = self else { return }
                
                self.noQuestionsLbl.isHidden = !isEmpty
                self.firstToAskLbl.isHidden = !isEmpty
                self.ifEmptyImage.isHidden = !isEmpty
                
                self.tableView.isHidden = isEmpty
            }
            .store(in: &cancellables)
        
        viewModel.$questions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                
                self?.updateUIForQuestions()
            }
            .store(in: &cancellables)
    }
    
    private func updateUIForQuestions() {
        if viewModel.isQuestionsEmpty {
            noQuestionsLbl.isHidden = false
            firstToAskLbl.isHidden = false
            ifEmptyImage.isHidden = false
            tableView.isHidden = true
        } else {
            noQuestionsLbl.isHidden = true
            firstToAskLbl.isHidden = true
            ifEmptyImage.isHidden = true
            tableView.isHidden = false
        }
    }
    
    private func updateButtonStyles(activeButton: UIButton) {
        let activeColor = UIColor(red: 78/255, green: 83/255, blue: 162/255, alpha: 1.0)
        let inactiveColor = UIColor(red: 119/255, green: 126/255, blue: 153/255, alpha: 1.0)
        
        generalButton.backgroundColor = activeButton == generalButton ? activeColor : inactiveColor
        personalButton.backgroundColor = activeButton == personalButton ? activeColor : inactiveColor
    }
}

extension HomePageViewController: AddQuestionDelegate {
    func didAddQuestion(title: String, question: String, tags: [String]) {
        let newQuestion = Question(id: 0, user: "User", subject: title, body: question, tagDetails: tags.map { Tag(name: $0) }, likeCount: 0, numberOfAnswers: 0, createdAt: "")
        
        viewModel.addNewQuestion(newQuestion)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.updateUIForQuestions()
        }
    }
}
extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as? QuestionCell else {
            return UITableViewCell()
        }
        
        let question = viewModel.questions[indexPath.row]
        
        cell.configure(with: question.subject, question: question.body, tags: question.tagDetails.map { $0.name })
        
        return cell
    }
}
    
    // MARK: ირა ეს შენთვისაა ამას ამოაკომენტებ და deatilsVC გაუწერ შენი მხარე რაცაა და რომ დააწვება გადმოვა ტიპი შენ ფეიჯზე
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedQuestion = viewModel.questions[indexPath.row]
//
//        let detailsVC = QuestionDetailsViewController()
//        detailsVC.question = selectedQuestion
//
//        navigationController?.pushViewController(detailsVC, animated: true)
//
//        tableView.deselectRow(at: indexPath, animated: true)


