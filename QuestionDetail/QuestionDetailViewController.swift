//import UIKit
//
//
//
//class QuestionDetailViewController: UIViewController {
//    
//    private var currentQuestion: AddQuestion?
//
//    
//    private let subjectTitle: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor(red: 198/255, green: 197/255, blue: 202/255, alpha: 1.0)
//        label.font = .systemFont(ofSize: 13, weight: .medium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
//    
//    private let questionTitle: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 16, weight: .regular)
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
//    
//    private let askedTitle: UILabel = {
//        let label = UILabel()
//        label.text = "@userNameHere asked on 11/24/2024 at 0:33"
//        label.textColor = UIColor(red: 94/255.0, green: 99/255.0, blue: 102/255.0, alpha: 1.0)
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
//    
//    private let profileImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "ProfileImage"))
//        imageView.layer.cornerRadius = 16
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return imageView
//    }()
//    
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Shawn Howard"
//        label.font = .systemFont(ofSize: 15, weight: .medium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
//    
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Monday, 9 May 2024"
//        label.textColor = UIColor(red: 94/255.0, green: 99/255.0, blue: 102/255.0, alpha: 1.0)
//        label.font = .systemFont(ofSize: 12, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
//    
//    private let answerLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris dfd"
//        label.font = .systemFont(ofSize: 16, weight: .regular)
//        label.numberOfLines = 3
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
//    
//    private let seeMoreButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("... see more", for: .normal)
//        button.setTitleColor(.systemBlue, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        return button
//    }()
//    
//    private let questionTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Type your question here"
//        textField.layer.borderColor = UIColor(red: 198/255, green: 197/255, blue: 202/255, alpha: 1.0).cgColor
//        textField.layer.borderWidth = 1
//        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
//        textField.leftViewMode = .always
//        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
//        textField.rightViewMode = .always
//        textField.layer.cornerRadius = 8
//        textField.layer.masksToBounds = true
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        return textField
//    }()
//    
//    private let sendButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "SendIcon"), for: .normal)
//        button.tintColor =  UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if let currentQuestion = currentQuestion {
//            updateQuestionDetails(subject: currentQuestion.subject,
//                                   questionText: currentQuestion.questionText)
//        }
//    }
//
// 
//    
//    func updateQuestionDetails(subject: String, questionText: String) {
//        subjectTitle.text = subject
//        questionTitle.text = questionText
//    }
//
//    
//    private func setupUI() {
//        view.backgroundColor = .white
//        
//        view.addSubview(subjectTitle)
//        view.addSubview(questionTitle)
//        view.addSubview(askedTitle)
//        
//        view.addSubview(profileImageView)
//        view.addSubview(nameLabel)
//        view.addSubview(dateLabel)
//        
//        view.addSubview(answerLabel)
//        view.addSubview(seeMoreButton)
//        
//        view.addSubview(questionTextField)
//        view.addSubview(sendButton)
//        
//        NSLayoutConstraint.activate([
//            subjectTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            subjectTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            questionTitle.topAnchor.constraint(equalTo: subjectTitle.bottomAnchor, constant: 16),
//            questionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            questionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            askedTitle.topAnchor.constraint(equalTo: questionTitle.bottomAnchor, constant: 8),
//            askedTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            
//            profileImageView.topAnchor.constraint(equalTo: askedTitle.bottomAnchor, constant: 16),
//            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            profileImageView.widthAnchor.constraint(equalToConstant: 34),
//            profileImageView.heightAnchor.constraint(equalToConstant: 34),
//            
//            nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10),
//            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
//            
//            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
//            dateLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
//
//            answerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
//            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            answerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            seeMoreButton.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 8),
//            seeMoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            questionTextField.topAnchor.constraint(equalTo: seeMoreButton.bottomAnchor, constant: 16),
//            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            questionTextField.heightAnchor.constraint(equalToConstant: 50),
//            
//            sendButton.centerYAnchor.constraint(equalTo: questionTextField.centerYAnchor),
//            sendButton.trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor, constant: -16),
//            sendButton.widthAnchor.constraint(equalToConstant: 44),
//            sendButton.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//    
//
//}
