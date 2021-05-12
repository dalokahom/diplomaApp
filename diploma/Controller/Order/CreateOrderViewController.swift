//
//  CreateOrderViewController.swift
//  diploma
//
//  Created by Ксения Чепурных on 04.05.2021.
//

import UIKit
import SnapKit

class CreateOrderViewController: UIViewController {
    
    var order: Order?
    
    var products: [Product] = []
    
    var changedProducts: [Int] = []
    
    var tableView = UITableView()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let orderTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "", isSecureTextEntry: false)
    }()
    
    private let clientNameTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "", isSecureTextEntry: false)
    }()
    
    private let clientPhoneNumberTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "", isSecureTextEntry: false)
    }()
    
    public let dateAndTimeTextField: UITextField = {
        let textField = UITextField().createTextField(withPlacehplder: "", isSecureTextEntry: false)
        let datePiker = UIDatePicker()
        datePiker.datePickerMode = .dateAndTime
        datePiker.locale = NSLocale(localeIdentifier: "ru-RU") as Locale
        textField.inputView = datePiker
        datePiker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        return textField
    }()
    
    private let priceTextField: UITextField = {
        return UITextField().createTextField(withPlacehplder: "", isSecureTextEntry: false)
    }()
    
    private lazy var orderContainer: UIView = {
        let view = UIView().createInputContainerViewWithLabel(text: "Заказ", textField: orderTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var clientNameContainer: UIView = {
        let view = UIView().createInputContainerViewWithLabel(text: "Имя", textField: clientNameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var clientPhoneNumberContainer: UIView = {
        let view = UIView().createInputContainerViewWithLabel(text: "Номер телефона", textField: clientPhoneNumberTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var dateAndTimeContainer: UIView = {
        let view = UIView().createInputContainerViewWithLabel(text: "Дата и время", textField: dateAndTimeTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let productsLabel: UILabel = {
        let label = UILabel()
        label.text = "Какие продукты вам понадобятся"
        label.font = UIFont(name: "Avenir-Light", size: 15)
        return label
    }()
    
    private lazy var priceContainer: UIView = {
        let view = UIView().createInputContainerViewWithLabel(text: "Стоимость заказа", textField: priceTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private var addOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        button.addShadow()
        button.layer.cornerRadius = 7
        button.backgroundColor = .peachTint
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(createOrder), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .peachTint
        
        backView.addShadow()
        
        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.snp.bottom).inset(30)
        }
        
        backView.addSubview(orderContainer)
        orderContainer.snp.makeConstraints { (make) in
            make.top.equalTo(backView.snp.top).offset(20)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
        }
        
        backView.addSubview(clientNameContainer)
        clientNameContainer.snp.makeConstraints { (make) in
            make.top.equalTo(orderContainer.snp.bottom).offset(10)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
        }
        
        backView.addSubview(clientPhoneNumberContainer)
        clientPhoneNumberContainer.snp.makeConstraints { (make) in
            make.top.equalTo(clientNameContainer.snp.bottom).offset(10)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
        }
        
        backView.addSubview(dateAndTimeContainer)
        dateAndTimeContainer.snp.makeConstraints { (make) in
            make.top.equalTo(clientPhoneNumberContainer.snp.bottom).offset(10)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
        }
        
        backView.addSubview(productsLabel)
        productsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateAndTimeContainer.snp.bottom).offset(10)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
        }
        
        configureTableView()
        
        backView.addSubview(priceContainer)
        priceContainer.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
        }
        
        backView.addSubview(addOrderButton)
        addOrderButton.snp.makeConstraints { (make) in
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
            make.bottom.equalTo(backView.snp.bottom).inset(20)
            make.height.equalTo(50)
        }
        

    }
    
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(productsLabel.snp.bottom).offset(5)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
            make.height.equalTo(200)
        }
        
        Service.shared.observeProducts { (products) in
            self.products = []
            self.products = products
            self.tableView.reloadData()
        }
    }
    
    @objc func valueChanged(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        dateFormat.dateFormat = "dd.MM.yyyy HH:mm"
        self.dateAndTimeTextField.text = dateFormat.string(from: sender.date)
    }
    
    @objc func createOrder() {
        guard let orderName = orderTextField.text else { return }
        guard let clientName = clientNameTextField.text else { return }
        guard let clientPhoneNumber = clientPhoneNumberTextField.text else { return }
        guard let date = dateAndTimeTextField.text else { return }
        guard let price = priceTextField.text else { return }
        
        
        Service.shared.createOrder(order: orderName, clientName: clientName, clientPhoneNumber: clientPhoneNumber, date: date, price: price) { (error, DatabaseReference) in
            if error != nil {
                print(error!)
            }
        }
        
        Service.shared.recreateProducts(products) { (error, DatabaseReference) in
            if error != nil {
                print(error!)
            }
        }
        
        self.dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension CreateOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.amountTextField.tag = indexPath.row
        cell.amountTextField.delegate = self
        cell.productNameLabel.text = products[indexPath.row].productName
        cell.productMeraLabel.text = products[indexPath.row].productMera

        return cell
    }

}

extension CreateOrderViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            #warning("TODO: можно сделать проверку на то что нам хватает того или иного продукта и если нет, то выводить алерт")
            let usedAmount = Int(textField.text ?? "0")
            //print(products[textField.tag].productAmount)
            products[textField.tag].productAmount = products[textField.tag].productAmount - usedAmount!
            //print(products[textField.tag].productAmount)
        }
        return true
    }

}
