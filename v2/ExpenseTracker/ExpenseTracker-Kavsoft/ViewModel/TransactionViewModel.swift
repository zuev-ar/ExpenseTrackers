//
//  TransactionViewModel.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 02.07.2023.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    // MARK: Properties
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    @Published var transactions: [Transaction] = transactionListPreviewData
    
    var filteredTransactions: [Transaction] {
        transactions.filter { transaction in
            transaction.date >= startDate && transaction.date <= endDate
        }
    }
    
    // MARK: Expense/Income Tab
    @Published var tabName: TransactionType = .income
    
    // MARK: Filter View
    @Published var showFilterView: Bool = false
    
    // MARK: New Expenses Properties
    @Published var addNewExpense: Bool = false
    //@Published var newTransaction: Transaction?
    
    @Published var remark: String = ""
    @Published var amount: String = ""
    @Published var type: TransactionType = .income
    @Published var date: Date = Date()
    
    init() {
        // MARK: Fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
        
        let componentsOfTime = DateComponents(hour: 23, minute: 59, second: 59)
        endDate = calendar.date(byAdding: componentsOfTime, to: calendar.startOfDay(for: Date()))!
    }
    
    // MARK: Fetching Current Month Date String
    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(
            date: .abbreviated,
            time: .omitted
        ) + " - " + Date().formatted(
            date: .abbreviated,
            time: .omitted
        )
    }
    
    func convertTransactionsToCurrency(type: TransactionType = .all) -> String {
        var value: Double = 0
        value = filteredTransactions.reduce(0, { partialResult, transaction in
            if type == .all {
                if transaction.type == .income {
                    return partialResult + transaction.amount
                } else {
                    return partialResult - transaction.amount
                }
            } else if transaction.type == type {
                return partialResult + transaction.amount
            }
            
            return partialResult
//            return partialResult + (type == .all ? (transaction.type == .income ? transaction.amount : -transaction.amount) : (transaction.type == type ? transaction.amount : 0))
        })

        return convertNumberToPrice(value: value)
    }
    
    // MARK: Converting Selected Dates To String
    func convertDateToString() -> String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    // MARK: Converting Number to Price
    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        let value = formatter.string(for: value)
        return formatter.string(for: value) ?? "0.00" + formatter.currencySymbol!
    }
    
    // MARK: Currency Symbol
    func currencySymbol() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.currencySymbol!
    }
    
    // MARK: Clearing All Data
    func clearData() {
        date = Date()
        type = .income
        remark = ""
        amount = ""
    }
    
    // MARK: Save Data
    func saveData() {
        let amountInDouble = (amount as NSString).doubleValue
        let colors = ["Yellow", "Red", "Purple", "Green"]
        let transaction = Transaction(
            remark: remark,
            amount: amountInDouble,
            date: date,
            type: type,
            color: colors.randomElement() ?? "Yellow"
        )
        transactions.append(transaction)
        transactions = transactions.sorted(by: { first, second in
            return second.date > first.date
        })
    }
}
