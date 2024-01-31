//
//  TransactionCardView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 04.07.2023.
//

import SwiftUI

struct TransactionCardView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    var isFilter: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color("Gradient1"),
                                 Color("Gradient2"),
                                 Color("Gradient3")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )
            
            VStack(spacing: 5) {
                VStack(spacing: 5) {
                    // MARK: Currently Going Month Date String
                    Text(isFilter ? transactionVM.convertDateToString() : transactionVM.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    // MARK: Current Month Transactions Price
                    Text(transactionVM.convertTransactionsToCurrency())
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
//                        .padding(.bottom, 5)
                }
//                .padding(.top, 5)
//                .offset(y: -10)
                
                HStack(spacing: 15) {
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(Color("Green"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(transactionVM.convertTransactionsToCurrency(type: .income))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(Color("Red"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expenses")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(transactionVM.convertTransactionsToCurrency(type: .expense))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .frame(height: 50)
                .padding(.horizontal)
                .padding(.trailing)
//                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 150)
//        .padding(.top)
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCardView()
            .environmentObject(TransactionViewModel())
    }
}
