//
//  HomeView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 02.07.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var transactionVM: TransactionViewModel = TransactionViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome:")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("ARK.ZV")
                            .font(.title2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NavigationLink {
                        FilteredDetailView()
                            .environmentObject(transactionVM)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content: {
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(Color.white, in:
                                            RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                
                TransactionCardView()
                    .environmentObject(transactionVM)
                
                TransactionListView()
                    .environmentObject(transactionVM)
            }
            .padding()
        }
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $transactionVM.addNewExpense) {
            transactionVM.clearData()
        } content: {
            TransactionNewView()
                .environmentObject(transactionVM)
        }
        .overlay(alignment: .bottomTrailing) {
            AddButton()
                .padding(.horizontal, 20)
        }
    }
    
    // MARK: Add New Transaction
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            transactionVM.addNewExpense.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 55, height: 55)
                .background {
                    Circle()
                        .fill(
                            LinearGradient(colors: [
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3")
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
