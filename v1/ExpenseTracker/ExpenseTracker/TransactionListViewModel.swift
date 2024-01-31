//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 24.06.2023.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpRespone = response as? HTTPURLResponse, httpRespone.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                // dump(self?.transactions)
            }
            .store(in: &cancellable)
    }
    
    func groupTransactionsByMonth() -> TransactionGroup  {
        guard !transactions.isEmpty else { return [:] }
        
        let groupTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        
        let today = "02/16/2022".dateParsed()
//        let today = Date.now
//        print(today.formatted(.dateTime.month().year().day()))
        
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
//        print("dateInterval:", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyEpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyEpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        
        return cumulativeSum
    }
    
    func updateCategory(transaction: Transaction, category: Category) {
        guard transaction.categoryId != category.id else { return }
        
        if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
            var updatedTransaction = transactions[index]
            updatedTransaction.categoryId = category.id
            updatedTransaction.isEdited = true
            transactions[index] = updatedTransaction
        }
    }
}
