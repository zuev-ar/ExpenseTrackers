//
//  TransactionListView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 04.07.2023.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Transactions")
                .font(.title.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            
            ForEach(transactionVM.transactions) { transaction in
                TransactionRowView(transaction: transaction)
                    .environmentObject(transactionVM)
            }
        }
        .padding(.top)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
            .environmentObject(TransactionViewModel())
            .frame(maxHeight: .infinity)
            .background {
                Color("BG")
                    .ignoresSafeArea()
            }
    }
}
