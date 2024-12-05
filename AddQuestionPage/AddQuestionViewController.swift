import UIKit

class AddQuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var tags: [String] = ["Frontend", "iOS", "SwiftUI", "SwiftUI", "iOS","Frontend", "iOS", "SwiftUI", "SwiftUI", "iOS"]
    private var selectedTags: [String] = []

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Question"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let subjectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Subject:"
        label.textColor = UIColor(red: 144/255, green: 144/255, blue: 147/255, alpha: 1.0)
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subjectTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    


    


    
    private let questionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your question here"
        textField.layer.borderColor = UIColor(red: 198/255, green: 197/255, blue: 202/255, alpha: 1.0).cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()

    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "SendIcon"), for: .normal)
        button.tintColor =  UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let subjectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let subjectBorderBottom: UIView = {
        let border = UIView()
        border.backgroundColor = UIColor(red: 198/255, green: 197/255, blue: 202/255, alpha: 1.0)
        border.translatesAutoresizingMaskIntoConstraints = false
        
        return border
    }()
    
    private let tagBottomBorder: UIView = {
        let border = UIView()
        border.backgroundColor = UIColor(red: 198/255, green: 197/255, blue: 202/255, alpha: 1.0)
        border.translatesAutoresizingMaskIntoConstraints = false
        
        return border
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var selectedTagsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "SelectedTagCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(selectedTagsCollectionView)
        view.addSubview(titleLabel)
        view.addSubview(cancelButton)
        view.addSubview(subjectView)
        subjectView.addSubview(subjectStackView)
        subjectView.addSubview(subjectBorderBottom)
        subjectStackView.addArrangedSubview(subjectLabel)
        subjectStackView.addArrangedSubview(subjectTextField)
        view.addSubview(questionTextField)
        view.addSubview(sendButton)
        view.addSubview(collectionView)
        
        subjectLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        subjectLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        subjectTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        subjectTextField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subjectView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subjectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subjectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            subjectView.heightAnchor.constraint(equalToConstant: 50),
            
            subjectStackView.topAnchor.constraint(equalTo: subjectView.topAnchor),
            subjectStackView.bottomAnchor.constraint(equalTo: subjectView.bottomAnchor),
            subjectStackView.leadingAnchor.constraint(equalTo: subjectView.leadingAnchor),
            subjectStackView.trailingAnchor.constraint(equalTo: subjectView.trailingAnchor),
            
            subjectBorderBottom.leadingAnchor.constraint(equalTo: subjectView.leadingAnchor),
            subjectBorderBottom.trailingAnchor.constraint(equalTo: subjectView.trailingAnchor),
            subjectBorderBottom.bottomAnchor.constraint(equalTo: subjectView.bottomAnchor),
            subjectBorderBottom.heightAnchor.constraint(equalToConstant: 1),
            
            collectionView.topAnchor.constraint(equalTo: selectedTagsCollectionView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            selectedTagsCollectionView.topAnchor.constraint(equalTo: subjectView.bottomAnchor, constant: 16),
            selectedTagsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectedTagsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            selectedTagsCollectionView.heightAnchor.constraint(equalToConstant: 50),

            questionTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            questionTextField.heightAnchor.constraint(equalToConstant: 50),
            
            sendButton.centerYAnchor.constraint(equalTo: questionTextField.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor, constant: -16),
            sendButton.widthAnchor.constraint(equalToConstant: 44),
            sendButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension AddQuestionViewController {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell else {
                fatalError("Unable to dequeue TagCell")
            }
            cell.configure(with: tags[indexPath.item])
            
            cell.tagButton.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        } else if collectionView == selectedTagsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedTagCell", for: indexPath) as? TagCell else {
                fatalError("Unable to dequeue SelectedTagCell")
            }
            cell.configure(with: selectedTags[indexPath.item])
            return cell
        }
        
        fatalError("Unexpected collection view")
    }

    @objc private func tagButtonTapped(_ sender: UIButton) {
        guard let tagText = sender.titleLabel?.text else { return }
        
        if !selectedTags.contains(tagText) {
            selectedTags.append(tagText)
            selectedTagsCollectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return tags.count
        } else if collectionView == selectedTagsCollectionView {
            return selectedTags.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == selectedTagsCollectionView {
            selectedTags.remove(at: indexPath.item)
            selectedTagsCollectionView.reloadData()
        }
    }
}

