//
//  Service.swift
//  diploma
//
//  Created by Ксения Чепурных on 03.05.2021.
//

import Foundation
import Firebase

let DB_REF = Database.database().reference()
let USERS_REF = DB_REF.child("users")

struct Service {
    static let shared = Service()
    
    let currentUID = Auth.auth().currentUser?.uid
    
    func createProduct(_ productName: String, productAmount: Int, productMera: String, price: Float, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let values = ["amount" : productAmount,
                      "mera" : productMera,
                      "price" : price] as [String : Any]
        
        USERS_REF.child(userUID).child("products").child(productName).updateChildValues(values, withCompletionBlock: completion)
    }
    
    func createOrder(order: String, clientName: String, clientPhoneNumber: String, date: String, price: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let values = ["clientName" : clientName,
                      "order" : order,
                      "date" : date,
                      "price" : price] as [String : Any]
        
        USERS_REF.child(userUID).child("orders").child(clientPhoneNumber).updateChildValues(values, withCompletionBlock: completion)
    }
    
    func observeProducts(copmpletion: @escaping([Product]) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        USERS_REF.child(userUID).child("products").observe(.value) { (snapshot) in
            var products: [Product] = []
            
            guard let dict = snapshot.value as? [String : [String : Any]] else { return }
            
            for i in dict {
                let productName = i.key
                let productAmaunt = i.value["amount"] as! Int
                let productMera = i.value["mera"] as! String
                let poductPrice = i.value["price"] as! Float
                
                let product = Product(productName: productName, productAmount: productAmaunt, price: poductPrice, productMera: productMera)
                products.append(product)
            }
            copmpletion(products)
        }
    }
    
    func recreateProducts(_ products: [Product], completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        for product in products {
            let values = ["amount" : product.productAmount,
                          "mera" : product.productMera,
                          "price" : product.price] as [String : Any]
            
            USERS_REF.child(userUID).child("products").child(product.productName).updateChildValues(values, withCompletionBlock: completion)
        }
    
    }
    
    func observeOrders(copmpletion: @escaping([Order]) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        USERS_REF.child(userUID).child("orders").observe(.value) { (snapshot) in
            var orders: [Order] = []
            
            guard let dict = snapshot.value as? [String : [String : Any]] else { return }
            
            for i in dict {
                let clientPhoneNumber = i.key
                let orderName = i.value["order"] as! String
                let clientName = i.value["clientName"] as! String
                let price = i.value["price"] as! String
                let date = i.value["date"] as! String
                
                let order = Order(order: orderName, clientName: clientName, clientPhoneNumber: clientPhoneNumber, date: date, price: Float(price) ?? 0.0)
                orders.append(order)
            }
            copmpletion(orders)
        }
    }
    
    func observeFinance(copmpletion: @escaping(Finance) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        USERS_REF.child(userUID).child("finance").observe(.value) { (snapshot) in
            
            guard let dict = snapshot.value as? [String : Any] else { return }
            
            let expenses = dict["expenses"] as! NSNumber
            let proceeds = dict["proceeds"] as! NSNumber
            let income = dict["income"] as! NSNumber
            
            let finance = Finance(expenses: expenses.floatValue, proceeds: proceeds.floatValue, income: income.floatValue)
            
            copmpletion(finance)
        }
    }
    
    func uploadFinanceData(_ finance: Finance, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let values = ["expenses" : finance.expenses,
                      "proceeds" : finance.proceeds,
                      "income" : finance.income] as [String : Float]
        
        
        USERS_REF.child(userUID).child("finance").updateChildValues(values, withCompletionBlock: completion)
    }
    
    func completeOrder(_ order: Order, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let values = ["clientName" : nil,
                      "order" : nil,
                      "date" : nil,
                      "price" : nil] as? [String : Any]
        USERS_REF.child(userUID).child("orders").child(order.clientPhoneNumber).updateChildValues(values!, withCompletionBlock: completion)
    }
}
