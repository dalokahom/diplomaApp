//
//  Product.swift
//  diploma
//
//  Created by Ксения Чепурных on 02.05.2021.
//

import Foundation

class Product {
    let productName: String
    var productAmount: Int
    let productMera: String
    let price: Float
    
    init(productName: String, productAmount: Int, price: Float, productMera: String) {
        self.productName = productName
        self.productAmount = productAmount
        self.productMera = productMera
        self.price = price
    }
    
    init?(dict: [String : Any]) {
        self.productName = dict["productName"] as? String ?? ""
        self.productAmount = dict["productAmount"] as? Int ?? 0
        self.productMera = dict["productMera"] as? String ?? ""
        self.price = dict["price"] as? Float ?? 0.0
    }
}
