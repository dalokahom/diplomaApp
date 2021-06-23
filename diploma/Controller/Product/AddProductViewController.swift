//
//  AddProductViewController.swift
//  diploma
//
//  Created by Ксения Чепурных on 03.05.2021.
//

import UIKit
import SnapKit

class AddProductViewController: UIViewController{
    
    private let addProductView = AddProductView()
    private var finance: Finance?
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProductView.delegate = self
        
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        
        view.addSubview(addProductView)
        addProductView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(390)
            make.width.equalTo(240)
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.height.equalTo(20)
        }
        
        Service.shared.observeFinance { (finance) in
            self.finance = finance
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true)
    }
    
}

extension AddProductViewController: AddProductViewDelegate {
    func createProduct() {
        guard let productName = addProductView.productNameTextField.text else { return }
        guard let productAmount = Int(addProductView.productAmountTextField.text ?? "0") else { return }
        guard let productMera = addProductView.productMeraTextField.text else { return }
        guard let productPrice = Float(addProductView.productPriceTextField.text ?? "0.0") else { return }
        
        Service.shared.createProduct(productName, productAmount: productAmount, productMera: productMera, price: productPrice) { (error, DatabaseReference) in
            if error != nil {
                print(error!)
            }
        }
        
        if finance == nil {
            let income = 0.0 - productPrice
            finance = Finance(expenses: productPrice, proceeds: 0.0, income: income)
            Service.shared.uploadFinanceData(finance!) { (error, DatabaseReference) in
                if error != nil {
                    print(error!)
                }
            }
        } else {
            finance?.expenses = finance!.expenses + productPrice
            finance?.income = finance!.income - productPrice
            Service.shared.uploadFinanceData(finance!) { (error, DatabaseReference) in
                if error != nil {
                    print(error!)
                }
            }
        }
        
        self.dismiss(animated: true)
    }
}
