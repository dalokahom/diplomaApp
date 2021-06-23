//
//  Extensions.swift
//  diploma
//
//  Created by Ксения Чепурных on 21.02.2021.
//

import UIKit
import SnapKit

// MARK: Text Field

extension UITextField {
    func createTextField(withPlacehplder placeholder: String, isSecureTextEntry: Bool) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.keyboardAppearance = .light
        textField.isSecureTextEntry = isSecureTextEntry
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray, .font: UIFont(name: "Avenir-Light", size: 15) ?? .boldSystemFont(ofSize: 15)])
        return textField
    }
}

// MARK: Label

extension UILabel {
    func createLogo() -> UILabel {
        let label = UILabel()
        label.text = " "
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label
    }
}

// MARK: View

extension UIView {
    func createInputContainerView(image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.width.height.equalTo(24)
            make.left.equalTo(0)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(-8)
        }
        
        let separator = UIView()
        separator.backgroundColor = .peachTint
        view.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        return view
    }
    
    func createInputContainerViewForAdding(textField: UITextField) -> UIView {
        let view = UIView()
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.right.equalTo(view)
        }
        
        let separator = UIView()
        separator.backgroundColor = .peachTint
        view.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(2)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        return view
    }
    
    func createInputContainerViewWithLabel(text: String, textField: UITextField) -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Avenir-Light", size: 15)
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.right.equalTo(view)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(2)
            make.left.right.equalTo(view)
        }
        
        let separator = UIView()
        separator.backgroundColor = .peachTint
        view.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(2)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        return view
    }
    
    func createLabelContainerView(image: UIImage, titleLabel: UILabel, sumLabel: UILabel) -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.width.height.equalTo(20)
            make.left.equalTo(0)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(8)
        }
        
        view.addSubview(sumLabel)
        sumLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.right.equalTo(view.snp.right)
        }
        
        return view
    }
    
    func createTextFielContainerView(textField: UITextField) -> UIView {
        let view = UIView()
        view.addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            //make.top.equalTo(view)
            make.left.right.equalTo(view)
        }
        
        let separator = UIView()
        separator.backgroundColor = .peachTint
        view.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom)
            //make.left.right.equalTo(view)
            make.height.equalTo(2)
            make.width.equalTo(view)
        }
        
        return view
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0.9, height: 0.9)
        layer.masksToBounds = false
    }
    
}

// MARK: Button

extension UIButton {
    func createAuthButton(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .peachTint
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }
    
    func createNavigationButton(text1: String, text2: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "\(text1) ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: text2, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.peachTint]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    
    func createAddButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .peachTint
        button.addShadow()
        button.layer.cornerRadius = 60/2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.titleLabel?.tintColor = .white
        return button
    }
}

// MARK: Color

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static let backgruondColor = UIColor.rgb(red: 241, green: 242, blue: 246)
    static let peachTint = UIColor(red: 0.94, green: 0.60, blue: 0.60, alpha: 1.00)//UIColor(red: 0.98, green: 0.91, blue: 0.91, alpha: 1.00)
    

}


extension UIViewController {
    func presentAlertController(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UITabBarController {
    func configureTabBar() -> UITabBarController {
        let tabBarContriller =  UITabBarController()
        tabBarContriller.tabBar.isTranslucent = false
        tabBarContriller.tabBar.tintColor = .peachTint
        
        let mainVC = MainViewController()
        mainVC.title = "Лента"
        let productVC = ProductViewController()
        productVC.title = "Продукты"
        let logOutVC = LogOutViewController()
        logOutVC.title = "Настройки"
        
        tabBarContriller.setViewControllers([mainVC, productVC, logOutVC], animated: false)
        
        guard let items = tabBarContriller.tabBar.items else { return tabBarContriller }
        
        let itemImages = ["calendar", "chart.bar.doc.horizontal.fill", "gear"]
        for i in 0..<itemImages.count {
            items[i].image = UIImage(systemName: itemImages[i])
        }
        
        return tabBarContriller
    }
}
