//
//  TransactionView.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 28.06.2023.
//

import SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        List {
            // MARK: Hero
            VStack(spacing: 6) {
                Text(transaction.signedAmount, format: .currency(code: "USD"))
                    .font(.largeTitle)
                    .bold()
                
                Text(transaction.merchant)
                    .lineLimit(1)
                
                Text(transaction.dateParsed.formatted(.dateTime.month(.wide).day()))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowSeparator(.hidden, edges: .top)
            .padding(.vertical, 16)
            
            // MARK: Merchant
            TransactionDetailRowView(icon: .store, title: "Merchant", text: transaction.merchant)
            
            // MARK: Date
            TransactionDetailRowView(icon: .calendar, title: "Date", text: transaction.dateParsed.formatted(.dateTime.year().month().day().weekday(.wide)))
            
            // MARK: Financial Institution
            TransactionDetailRowView(icon: .landmark, title: "Financial Institution", text: transaction.institution)
            
            // MARK: Account
            TransactionDetailRowView(icon: .credit_card, title: "Account", text: transaction.account)
            
            // MARK: Category
            NavigationLink {
                CategoryView(transaction: transaction)
            } label: {
                TransactionDetailRowView(icon: .list, title: "Category", text: transaction.categoryItem.name)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TransactionView(transaction: transactionPreviewData)
        }
    }
}
