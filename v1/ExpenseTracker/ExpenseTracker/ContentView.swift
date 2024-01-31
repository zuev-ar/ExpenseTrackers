//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 30.01.2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart
                    let data = transactionListVM.accumulateTransactions()
                    
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "%.02f $")
                                LineChart()
                            }
                            .background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 250)
                    }
                    
                    // MARK: Transaction List
                    TransactionRecentListView()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
//            .toolbar {
//                // MARK: Notification Icon
//                ToolbarItem {
//                    Image(systemName: "bell.badge")
//                        .symbolRenderingMode(.palette)
//                        .foregroundStyle(Color.icon, .black)
//                }
//            }
        }
        .tint(Color.text)
    }
}

//#Preview {
//    let transactionListVM: TransactionListViewModel = {
//        let transactionListVM = TransactionListViewModel()
//        transactionListVM.transactions = transactionListPreviewData
//        return transactionListVM
//    }()
//    
//    ContentView()
//        .environmentObject(transactionListVM)
//}
