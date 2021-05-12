//
//  OrderCell.swift
//  diploma
//
//  Created by Ксения Чепурных on 09.05.2021.
//

import UIKit
import SnapKit

class OrderCell: UITableViewCell {
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказ"
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label
    }()
    
    public let clientNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя клиента"
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label
    }()
    
    public let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.textColor = UIColor(white: 0, alpha: 0.8)
        return label
    }()
    
    private let arrowView: UIView = {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "right-arrow")
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.width.height.equalTo(24)
            make.left.equalTo(0)
        }
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.left.equalTo(self.snp.left)
        }
        
        addSubview(clientNameLabel)
        clientNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(clientNameLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left)
        }
        
        addSubview(arrowView)
        arrowView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
