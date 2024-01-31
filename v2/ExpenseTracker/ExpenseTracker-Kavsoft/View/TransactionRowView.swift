//
//  TransactionRowView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 04.07.2023.
//

import SwiftUI

struct TransactionRowView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            // MARK: First Letter Avatar
            if let first = transaction.remark.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(Color(transaction.color))
                    )
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
            }
            
            Text(transaction.remark)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing, spacing: 7) {
                // MARK: Displaying Price
                let price = transactionVM.convertNumberToPrice(value: transaction.type == .expense ? -transaction.amount : transaction.amount)
                
                Text(price)
                    .font(.callout)
                    .opacity(0.9)
                    .foregroundColor(transaction.type == .expense ? Color("Red") : Color("Green"))
                
                Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .opacity(0.5)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(transaction: transactionPreviewData)
            .environmentObject(TransactionViewModel())
            .frame(maxHeight: .infinity)
            .background {
                Color("BG")
                    .ignoresSafeArea()
            }
    }
}
