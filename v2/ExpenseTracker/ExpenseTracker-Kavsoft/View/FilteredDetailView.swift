//
//  FilteredDetailView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 04.07.2023.
//

import SwiftUI

struct FilteredDetailView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    @Environment(\.self) var environment
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 5) {
                HStack(spacing: 15) {
                    // MARK: Back Button
                    Button {
                        environment.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in:
                                            RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    
                    Text("Transactions")
                        .font(.title.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        transactionVM.showFilterView.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in:
                                            RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }

                }
                
                // MARK: Transaction Card View For Currently Selected Date
                TransactionCardView(isFilter: true)
                    .environmentObject(transactionVM)
                
                CustomSegmentedControl(tabName: $transactionVM.tabName)
                    .padding(.top, 10)
                
                // MARK: Currently Filtered Date With Amount
                VStack(spacing: 15) {
                    Text(transactionVM.convertDateToString())
                        .opacity(0.7)
                    
                    Text(transactionVM.convertTransactionsToCurrency(type: transactionVM.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: transactionVM.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical, 10)
                
                ForEach(transactionVM.transactions.filter { return $0.type == transactionVM.tabName } ) { transaction in
                    TransactionRowView(transaction: transaction)
                        .environmentObject(transactionVM)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay {
            DateFilterView()
                .environmentObject(transactionVM)
        }
    }
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView()
            .environmentObject(TransactionViewModel())
    }
}
