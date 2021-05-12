//
//  LoginViewController.swift
//  diploma
//
//  Created by Ксения Чепурных on 02.05.2021.
//

import UIKit
import Firebase
import SnapKit

class LoginViewController: UIViewController {

    // MARK: UI Properties
    
    private let titleLabel: UILabel = {
        return UILabel().createLogo()
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "Email", isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "Пароль", isSecureTextEntry: false)
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().createInputContainerView(image: #imageLiteral(resourceName: "email-envelope"), textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().createInputContainerView(image: #imageLiteral(resourceName: "padlock"), textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton().createAuthButton(text: "Войти")
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton().createNavigationButton(text1: "Не зарегистрированы?", text2: "Зарегистрироваться")
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Functions
    
    func configureUI() {
        
        view.backgroundColor = .backgruondColor
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 25
        
        view.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).inset(40)
            make.centerX.equalTo(view)
        }
    }
    
    // MARK: - Navigation
    @objc func logIn() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed with \(error.localizedDescription)")
            }
            
            let mainVC = UITabBarController().configureTabBar()
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true)
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = SignUpViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
        //navigationController?.pushViewController(controller, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
