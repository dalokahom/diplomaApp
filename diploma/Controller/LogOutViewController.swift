//
//  LogOutViewController.swift
//  diploma
//
//  Created by Ксения Чепурных on 12.05.2021.
//

import UIKit
import Firebase
import SnapKit

class LogOutViewController: UIViewController {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.addShadow()
        return view
    }()
    
    private let emailLabel: UILabel = {
        return UILabel().createLabel(text: "")
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton().createAuthButton(text: "Выйти")
        button.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .peachTint

        guard let email = Auth.auth().currentUser?.email else { return }
        emailLabel.text = email
        
        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        backView.addShadow()
        
        backView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backView.snp.centerY)
            make.centerX.equalTo(backView.snp.centerX)
        }
        
        backView.addSubview(logOutButton)
        logOutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
            make.bottom.equalTo(backView.snp.bottom).offset(-20)
        }
        
        
    }
    
    @objc func handleLogOut() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
        
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
