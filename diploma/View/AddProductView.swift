//
//  AddProductView.swift
//  diploma
//
//  Created by Ксения Чепурных on 03.05.2021.
//

import UIKit
import SnapKit

class AddProductView: UIView {
    
    var delegate: AddProductViewDelegate?
    
    public let productNameTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "Шоколад", isSecureTextEntry: false)
    }()
    
    public let productAmountTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "100", isSecureTextEntry: false)
    }()
    
    public let productMeraTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "шт", isSecureTextEntry: false)
    }()
    
    public let productPriceTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "150.99", isSecureTextEntry: false)
    }()
    
    private lazy var productNameContainer: UIView = {
        let view = UIView().createInputContainerViewForAdding(textField: productNameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var productAmountContainer: UIView = {
        let view = UIView().createInputContainerViewForAdding(textField: productAmountTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var productMeraContainer: UIView = {
        let view = UIView().createInputContainerViewForAdding(textField: productMeraTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var productPriceContainer: UIView = {
        let view = UIView().createInputContainerViewForAdding(textField: productPriceTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel().createLabel(text: "Название продукта")
        return label
    }()
    
    private var amountLabel: UILabel = {
        let label = UILabel().createLabel(text: "Количество")
        return label
    }()
    
    private var meraLabel: UILabel = {
        let label = UILabel().createLabel(text: "Мера")
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel().createLabel(text: "Цена")
        return label
    }()
    
    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = .peachTint
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.addTarget(self, action: #selector(createProduct), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 30
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, productNameContainer, amountLabel, productAmountContainer, meraLabel, productMeraContainer, priceLabel, productPriceContainer, addButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(self.snp.bottom).inset(20)
        }
        
        
    }
    
    @objc func createProduct() {
        delegate?.createProduct()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol AddProductViewDelegate {
    func createProduct()
}
