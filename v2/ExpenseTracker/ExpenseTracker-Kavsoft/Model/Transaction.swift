//
//  Transaction.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 02.07.2023.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: TransactionType
    var color: String
}

enum TransactionType: String {
    case income = "Income"
    case expense = "Expenses"
    case all = "All"
}
