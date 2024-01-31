//
//  PreviewData.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 02.07.2023.
//

import Foundation

var transactionPreviewData = Transaction(
    remark: "Magic Keyboard",
    amount: 99,
    date: Date(timeIntervalSince1970: 1652987245),
    type: .expense,
    color: "Yellow"
)

//var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)

var transactionListPreviewData: [Transaction] = [
    Transaction(
        remark: "Salary",
        amount: 1000,
        date: Date(timeIntervalSince1970: 1652987245),
        type: .income,
        color: "Red"
    ),
    Transaction(
        remark: "Magic Keyboard",
        amount: 99,
        date: Date(timeIntervalSince1970: 1652987247),
        type: .expense,
        color: "Yellow"
    )
]
