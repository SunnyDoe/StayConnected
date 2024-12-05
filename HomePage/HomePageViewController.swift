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
        return label
    }()
    
    private let firstToAskLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ifEmptyImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "IfEmpty"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let viewModel: HomePageViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HomePageViewModel = HomePageViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupButtonActions()
        bindViewModel()
        
        updateButtonStyles(activeButton: generalButton)
    }
    
    private func setupUI() {
        view.addSubview(questionLbl)
        view.addSubview(addButton)
        view.addSubview(buttonStackView)
        view.addSubview(noQuestionsLbl)
        view.addSubview(firstToAskLbl)
        view.addSubview(ifEmptyImage)

        buttonStackView.addArrangedSubview(generalButton)
        buttonStackView.addArrangedSubview(personalButton)

        NSLayoutConstraint.activate([
            questionLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            questionLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            buttonStackView.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12),
            buttonStackView.heightAnchor.constraint(equalToConstant: 39),

            noQuestionsLbl.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 91),
            noQuestionsLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstToAskLbl.topAnchor.constraint(equalTo: noQuestionsLbl.bottomAnchor, constant: 13),
            firstToAskLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            ifEmptyImage.topAnchor.constraint(equalTo: firstToAskLbl.bottomAnchor, constant: 19),
            ifEmptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupButtonActions() {
        generalButton.addTarget(self, action: #selector(generalButtonTapped), for: .touchUpInside)
        personalButton.addTarget(self, action: #selector(personalButtonTapped), for: .touchUpInside)
    }
    
    @objc private func generalButtonTapped() {
        viewModel.switchQuestionType(to: .general)
    }

    @objc private func personalButtonTapped() {
        viewModel.switchQuestionType(to: .personal)
    }
    
    private func bindViewModel() {
        viewModel.$currentQuestionType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] questionType in
                guard let self = self else { return }
                
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
            }
            .store(in: &cancellables)
        
        viewModel.$isQuestionsEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEmpty in
                self?.noQuestionsLbl.isHidden = !isEmpty
                self?.firstToAskLbl.isHidden = !isEmpty
                self?.ifEmptyImage.isHidden = !isEmpty
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper Methods
    private func updateButtonStyles(activeButton: UIButton) {
        let activeColor = UIColor(red: 78/255, green: 83/255, blue: 162/255, alpha: 1.0)
        let inactiveColor = UIColor(red: 119/255, green: 126/255, blue: 153/255, alpha: 1.0)
        
        generalButton.backgroundColor = activeButton == generalButton ? activeColor : inactiveColor
        personalButton.backgroundColor = activeButton == personalButton ? activeColor : inactiveColor
    }
}
