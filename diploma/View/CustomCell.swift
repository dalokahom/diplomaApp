//
//  CustomCell.swift
//  diploma
//
//  Created by Ксения Чепурных on 04.05.2021.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.text = "cell label"
        return label
    }()
    
    let productAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.text = "190"
        return label
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
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        addSubview(productMeraLabel)
        productMeraLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        
        addSubview(productAmountLabel)
        productAmountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(productMeraLabel.snp.left).offset(-5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
