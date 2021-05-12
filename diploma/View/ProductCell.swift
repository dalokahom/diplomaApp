//
//  ProductCell.swift
//  diploma
//
//  Created by Ксения Чепурных on 05.05.2021.
//

import UIKit
import SnapKit

class ProductCell: UITableViewCell {
    
    public let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.text = "cell label"
        return label
    }()
    
    public let amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black
        textField.keyboardAppearance = .light
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [.foregroundColor: UIColor.gray, .font: UIFont(name: "Avenir-Light", size: 15) ?? .boldSystemFont(ofSize: 15)])
        return textField
    }()
    
    lazy var amountTextFieldContainer: UIView = {
        var view = createInputContainerViewForAdding(textField: amountTextField)
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let productMeraLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.text = "шт"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(20)
        }

        let stack = UIStackView(arrangedSubviews: [amountTextFieldContainer, productMeraLabel])
        stack.axis = .horizontal
        //stack.distribution = .fillEqually
        stack.spacing = 3

        contentView.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
