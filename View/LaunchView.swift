//
//  LaunchView.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 28.11.24.
//

import UIKit


class LaunchView: UIViewController {
    
    private let viewModel = LaunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.startLaunchTimer()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.33, green: 0.4, blue: 0.87, alpha: 1.0)
        
        let logoImageView = UIImageView(image: UIImage(named: "5336958 1"))
        logoImageView.tintColor = .white
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Stay Connected"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupBindings() {
        viewModel.onTransitionToLogin = { [weak self] in
            self?.navigateToLogin()
        }
    }
    
    private func navigateToLogin() {
        if let navigationController = self.navigationController {
            let loginVC = LoginView()
            navigationController.pushViewController(loginVC, animated: true)
        }
    }
}
