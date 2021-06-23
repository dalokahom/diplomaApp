//
//  OrderViewController.swift
//  diploma
//
//  Created by Ксения Чепурных on 09.05.2021.
//

import UIKit

class OrderViewController: UIViewController {
    
    public var order: Order?
    private var finance: Finance?
    
    private let orderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказ"
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label

    }()
    
    private let clientNameTitleLabel: UILabel = {
        return UILabel().createLabel(text: "Имя клиента")
    }()
    
    private let clientNameLabel: UILabel = {
        return UILabel().createLabel(text: " ")
    }()
    
    private let clientPhoneNumberTitleLabel: UILabel = {
        return UILabel().createLabel(text: "Номер телефона")
    }()
    
    private let clientPhoneNumberLabel: UILabel = {
        return UILabel().createLabel(text: " ")
    }()
    
    private let dateTitleLabel: UILabel = {
        return UILabel().createLabel(text: "Дата")
    }()
    
    private let dateLabel: UILabel = {
        return UILabel().createLabel(text: " ")
    }()
    
    private let priceTitleLabel: UILabel = {
        return UILabel().createLabel(text: "Стоимость заказа")
    }()
    
    private let priceLabel: UILabel = {
        return UILabel().createLabel(text: " ")
    }()
    
    lazy private var clientNameContainer: UIView = {
        return UIView().createLabelContainerView(image: #imageLiteral(resourceName: "user"), titleLabel: clientNameTitleLabel, sumLabel: clientNameLabel)
    }()
    
    lazy private var clientPhoneNumberContainer: UIView = {
        return UIView().createLabelContainerView(image: #imageLiteral(resourceName: "phone-call"), titleLabel: clientPhoneNumberTitleLabel, sumLabel: clientPhoneNumberLabel)
    }()
    
    lazy private var dateContainer: UIView = {
        return UIView().createLabelContainerView(image: #imageLiteral(resourceName: "calendar"), titleLabel: dateTitleLabel, sumLabel: dateLabel)
    }()
    
    lazy private var priceContainer: UIView = {
        return UIView().createLabelContainerView(image: #imageLiteral(resourceName: "wallet"), titleLabel: priceTitleLabel, sumLabel: priceLabel)
    }()
    
    private var viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        return view
    }()
    
    private var completeOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Завершить заказ", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = .peachTint
        button.addShadow()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(completeOrder), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.observeFinance { (finance) in
            self.finance = finance
        }
        
        view.addShadow()
        view.backgroundColor = .peachTint
        
        viewContainer.addShadow()
        
        orderTitleLabel.text = order?.order
        clientNameLabel.text = order?.clientName
        clientPhoneNumberLabel.text = order?.clientPhoneNumber
        dateLabel.text = order?.date
        priceLabel.text = String(order!.price)
        
        view.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.snp.bottom).offset(-20)
        }
        
        viewContainer.addSubview(orderTitleLabel)
        orderTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(viewContainer.snp.top).offset(20)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        viewContainer.addSubview(clientNameContainer)
        clientNameContainer.snp.makeConstraints { (make) in
            make.top.equalTo(orderTitleLabel.snp.bottom).offset(40)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        viewContainer.addSubview(clientPhoneNumberContainer)
        clientPhoneNumberContainer.snp.makeConstraints { (make) in
            make.top.equalTo(clientNameContainer.snp.bottom).offset(40)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        viewContainer.addSubview(dateContainer)
        dateContainer.snp.makeConstraints { (make) in
            make.top.equalTo(clientPhoneNumberContainer.snp.bottom).offset(40)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        viewContainer.addSubview(priceContainer)
        priceContainer.snp.makeConstraints { (make) in
            make.top.equalTo(dateContainer.snp.bottom).offset(40)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        viewContainer.addSubview(completeOrderButton)
        completeOrderButton.snp.makeConstraints { (make) in
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
            make.bottom.equalTo(viewContainer.snp.bottom).offset(-20)
        }
    }
    
    @objc func completeOrder() {
        if finance == nil {
            finance = Finance(expenses: 0.0, proceeds: order!.price, income: order!.price)
            Service.shared.uploadFinanceData(finance!) { (error, DatabaseReference) in
                if error != nil {
                    print(error)
                }
            }
        } else {
            finance?.proceeds = finance!.proceeds + order!.price
            finance?.income = finance!.income + order!.price
            Service.shared.uploadFinanceData(finance!) { (error, DatabaseReference) in
                if error != nil {
                    print(error)
                }
            }
        }
        
        Service.shared.completeOrder(order!) { (error, DatabaseReference) in
            if error != nil {
                print(error)
            }
        }
        
        self.dismiss(animated: true)
    }


}
