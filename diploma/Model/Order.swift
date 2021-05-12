//
//  Order.swift
//  diploma
//
//  Created by Ксения Чепурных on 05.05.2021.
//

import Foundation

class Order {
    
    let order: String
    let clientName: String
    let clientPhoneNumber: String
    let date: String
    let price: Float
    
    init(order: String, clientName: String, clientPhoneNumber: String, date: String, price: Float) {
        self.order = order
        self.clientName = clientName
        self.clientPhoneNumber = clientPhoneNumber
        self.date = date
        self.price = price
    }
    
}
