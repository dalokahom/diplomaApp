//
//  MainViewController.swift
//  diploma
//
//  Created by Ксения Чепурных on 07.05.2021.
//

import UIKit
import SnapKit

//protocol MainViewControllerDelegate: class {
//    func handleMenuToggle()
//}

class MainViewController: UIViewController {
    
//    weak var delegate: MainViewControllerDelegate?
    
    private var orders: [Order] = []
    
    private let financialView = FinancialView()
    private let tableView = UITableView()
    
    private let tableViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.addShadow()
        return view
    }()
    
    private let ordersTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ближайшие заказы"
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label
    }()
    
    var createOrderButton: UIButton = {
        let button = UIButton().createAddButton()
        button.addTarget(self, action: #selector(createOrder), for: .touchUpInside)
        return button
    }()
    
    lazy private var menuButton = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(menuButonAction))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setLeftBarButton(menuButton, animated: false)//leftBarButtonItem = menuButton
        title = "Лента"
        //self.navigationController?.navigationBar.barTintColor = .peachTint
        
        view.backgroundColor = .peachTint
        configureTableView()
        
        Service.shared.observeOrders { (orders) in
            self.orders = []
            self.orders = orders
            self.tableView.reloadData()
        }
        
        Service.shared.observeFinance { (finance) in
            self.financialView.proceedsSumLabel.text = String(finance.proceeds)
            self.financialView.expensesSumLabel.text = String(finance.expenses)
            self.financialView.incomeSumLabel.text = String(finance.income)
        }
        
        
        view.addSubview(financialView)
        financialView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)//.offset(10)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(175)
        }
        
        view.addSubview(tableViewContainer)
        tableViewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(financialView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.snp.bottom).inset(20)
        }
        
        tableViewContainer.addSubview(ordersTitleLabel)
        ordersTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tableViewContainer.snp.top).offset(20)
            make.left.equalTo(tableViewContainer.snp.left).offset(20)
            make.right.equalTo(tableViewContainer.snp.right).offset(-20)
        }
        
        tableViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(ordersTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(tableViewContainer.snp.left).offset(20)
            make.right.equalTo(tableViewContainer.snp.right).offset(-20)
            make.bottom.equalTo(tableViewContainer.snp.bottom).offset(-20)
        }
        
        view.addSubview(createOrderButton)
        createOrderButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.right.equalTo(view.snp.right).offset(-30)
            make.bottom.equalTo(view.snp.bottom).offset(-30)
        }
        
        
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
    }
    
    @objc func menuButonAction() {
        print("action")
        //delegate?.handleMenuToggle()
    }
    
    @objc func createOrder() {
        let vc = CreateOrderViewController()
        //vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }


}

// MARK: - Table view data source

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.titleLabel.text = orders[indexPath.row].order
        cell.clientNameLabel.text = orders[indexPath.row].clientName
        cell.dateLabel.text = orders[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderViewController()
        //vc.modalPresentationStyle = .fullScreen
        vc.order = orders[indexPath.row]
        self.present(vc, animated: true)
    }
    
}
