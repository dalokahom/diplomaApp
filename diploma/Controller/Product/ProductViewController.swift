//
//  ProductViewController.swift
//  diploma
//
//  Created by Ксения Чепурных on 02.05.2021.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    private var products: [Product] = []
    
    private let tableView = UITableView()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.addShadow()
        return view
    }()
    
    var addProductButton: UIButton = {
        let button = UIButton().createAddButton()
        button.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .peachTint
        
        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        configureTableView()
        
        title = "Продукты"

        view.addSubview(addProductButton)
        addProductButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).inset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.width.equalTo(60)
        }
        
        Service.shared.observeProducts { (products) in
            self.products = []
            self.products = products
            self.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        
        backView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(backView.snp.top).offset(20)
            make.left.equalTo(backView.snp.left).offset(20)
            make.right.equalTo(backView.snp.right).offset(-20)
            make.bottom.equalTo(backView.snp.bottom).offset(-20)
        }
    }
    
        
    @objc func addProduct() {
        
        let vc = AddProductViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }

}

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.productNameLabel.text = products[indexPath.row].productName
        cell.productAmountLabel.text = String(products[indexPath.row].productAmount)
        cell.productMeraLabel.text = products[indexPath.row].productMera

        return cell
    }

}

