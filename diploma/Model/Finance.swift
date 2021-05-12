//
//  Finance.swift
//  diploma
//
//  Created by Ксения Чепурных on 08.05.2021.
//

import Foundation

class Finance {
    var expenses: Float
    var proceeds: Float
    var income: Float
    
    init(expenses: Float, proceeds: Float, income: Float) {
        self.expenses = expenses
        self.proceeds = proceeds
        self.income = income
    }
}
