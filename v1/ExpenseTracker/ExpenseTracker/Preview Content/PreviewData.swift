//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 24.06.2023.
//

import Foundation

var transactionPreviewData = Transaction(
    id: 1,
    date: "01/24/2022",
    institution: "Desjardians",
    account: "Visa Desjardins",
    merchant: "Apple",
    amount: 11.49,
    type: "debit",
    categoryId: 801,
    category: "Software",
    isPending: false,
    isTransfer: false,
    isExpense: true,
    isEdited: true
)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
