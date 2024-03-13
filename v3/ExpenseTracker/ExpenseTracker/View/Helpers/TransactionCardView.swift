//
//  TransactionCardView.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 22.02.2024.
//

import SwiftUI

struct TransactionCardView: View {
    var transaction: Transaction
    var showsCategory: Bool = false
    
    private var currencyString: String {
        let symbol = transaction.category == Category.income.rawValue ? "" : "-"
        return "\(symbol)\(currencyString(transaction.amount, allowedDigits: 2))"
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Text("\(String(transaction.title.prefix(1)))")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .background(transaction.color.gradient, in: .circle)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .foregroundStyle(Color.primary)
                
                Text(transaction.remarks)
                    .font(.caption)
                    .foregroundStyle(Color.primary.secondary)
                
                Text(format(date: transaction.dateAdded, format: "dd.MM.yy"))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                if showsCategory {
                    Text(transaction.category)
                        .font(.caption2)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .foregroundStyle(.white)
                        .background(
                            transaction.category == Category.income.rawValue
                            ? Color.green.gradient : Color.red.gradient,
                            in: .capsule)
                }
            }
            .lineLimit(1)
            .hSpacing(.leading)
            
            Text(currencyString)
                .fontWeight(.semibold)
                .foregroundStyle(transaction.rawCategory == Category.income ? .green : .red)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.background, in: .rect(cornerRadius: 10))
    }
}

#Preview {
    ContentView()
}
