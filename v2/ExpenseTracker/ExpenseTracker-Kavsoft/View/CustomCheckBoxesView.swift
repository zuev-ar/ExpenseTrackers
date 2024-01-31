//
//  CustomCheckBoxesView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 29.01.2024.
//

import SwiftUI

struct CustomCheckBoxesView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        
        HStack(spacing: 10) {
            ForEach([TransactionType.income, TransactionType.expense], id: \.self) { type in
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black, lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)
                    
                    if transactionVM.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundStyle(.green)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    transactionVM.type = type
                }
                
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
    }
}

#Preview {
    CustomCheckBoxesView()
        .environmentObject(TransactionViewModel())
}
