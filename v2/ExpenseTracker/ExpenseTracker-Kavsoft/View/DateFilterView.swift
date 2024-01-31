//
//  DateFilterView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 07.07.2023.
//

import SwiftUI

struct DateFilterView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(transactionVM.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            // MARK: Based On The Date Filter Expenses Array
            if transactionVM.showFilterView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)
                    
                    DatePicker("", 
                               selection: $transactionVM.startDate,
                               in: Date.distantPast...Date(),
                               displayedComponents: [.date, .hourAndMinute]
                    )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 10)
                    
                    DatePicker("", 
                               selection: $transactionVM.endDate,
                               in: Date.distantPast...Date(),
                               displayedComponents: [.date, .hourAndMinute]
                    )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                }
                .padding()
                .padding(.horizontal, 10)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                // MARK: Close Button
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        transactionVM.showFilterView.toggle()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(5)
                    }

                })
                .padding()
            }
        }
        .animation(.easeInOut, value: transactionVM.showFilterView)
    }
}

struct DateFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DateFilterView()
            .environmentObject(TransactionViewModel())
    }
}
