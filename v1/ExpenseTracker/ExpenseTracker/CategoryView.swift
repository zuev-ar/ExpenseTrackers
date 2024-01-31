//
//  CategoryView.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 28.06.2023.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @Environment(\.dismiss) var dismiss
    var transaction: Transaction
    
    var body: some View {
        List {
            ForEach(Category.categories) { category in
                Section {
                    // MARK: Subcategories
                    ForEach(category.subcategories ?? []) { subcategory in
                        let isSelected = transaction.categoryId == subcategory.id
                        
                        CategoryRowView(category: subcategory, isSelected: isSelected)
                            .onTapGesture {
                                transactionListVM.updateCategory(transaction: transaction, category: subcategory)
                                dismiss()
                            }
                    }
                    
                } header: {
                    // MARK: Categories
                    let isSelected = transaction.categoryId == category.id
                    
                    CategoryRowView(category: category, isSelected: isSelected)
                        .onTapGesture {
                            transactionListVM.updateCategory(transaction: transaction, category: category)
                            dismiss()
                        }
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(transaction: transactionPreviewData)
            .environmentObject(TransactionListViewModel())
    }
}
