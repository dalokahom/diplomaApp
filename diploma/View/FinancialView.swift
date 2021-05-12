//
//  FinancialView.swift
//  diploma
//
//  Created by Ксения Чепурных on 07.05.2021.
//

import UIKit
import SnapKit

class FinancialView : UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Итоги за месяц"
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label
    }()
    
    private let expensesLabel: UILabel = {
        return UILabel().createLabel(text: "Расходы")
    }()
    
    private let proceedsLabel: UILabel = {
        return UILabel().createLabel(text: "Выручка")
    }()
    
    private let incomeLabel: UILabel = {
        return UILabel().createLabel(text: "Доход")
    }()
    
    public let expensesSumLabel: UILabel = {
        return UILabel().createLabel(text: "0.0")
    }()
    
    public let proceedsSumLabel: UILabel = {
        return UILabel().createLabel(text: "0.0")
    }()
    
    public let incomeSumLabel: UILabel = {
        return UILabel().createLabel(text: "0.0")
    }()
    
    private lazy var expensesContainer: UIView = {
        let view = UIView().createLabelContainerView(image: #imageLiteral(resourceName: "coin-stack"), titleLabel: expensesLabel, sumLabel: expensesSumLabel)
        return view
    }()
    
    private lazy var proceedsContainer: UIView = {
        let view = UIView().createLabelContainerView(image: #imageLiteral(resourceName: "wallet"), titleLabel: proceedsLabel, sumLabel: proceedsSumLabel)
        return view
    }()
    
    private lazy var incomeContainer: UIView = {
        let view = UIView().createLabelContainerView(image: #imageLiteral(resourceName: "like"), titleLabel: incomeLabel, sumLabel: incomeSumLabel)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 30
        addShadow()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        addSubview(expensesContainer)
        expensesContainer.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        addSubview(proceedsContainer)
        proceedsContainer.snp.makeConstraints { (make) in
            make.top.equalTo(expensesContainer.snp.bottom).offset(35)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        addSubview(incomeContainer)
        incomeContainer.snp.makeConstraints { (make) in
            make.top.equalTo(proceedsContainer.snp.bottom).offset(35)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
