//
//  CategoryRowView.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 28.06.2023.
//

import SwiftUI
import SwiftUIFontIcon

struct CategoryRowView: View {
    var category: Category
    var isSelected: Bool
    
    var isMain: Bool {
        category.mainCategoryId == nil
    }
    
    var frameSize: CGFloat {
        isMain ? 44 : 32
    }
    
    var fontSize: CGFloat {
        isMain ? 24 : 16
    }
    
    var body: some View {
        HStack {
            // MARK: Category Icon
            VStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.icon.opacity(0.3))
                    .frame(width: frameSize, height: frameSize)
                    .overlay {
                        FontIcon.text(.awesome5Solid(code: category.icon), fontsize: fontSize, color: Color.icon)
                    }
            }
            .frame(width: 50)
            
            // MARK: Category Name
            if isMain {
                Text(category.name)
                    .foregroundColor(.primary)
            } else {
                Text(category.name)
                    .font(.subheadline)
            }
            
            Spacer()
            
            // MARK: Checkmark
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color.icon)
            }
        }
        .contentShape(Rectangle())
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: .billsAndUtilities, isSelected: true)
    }
}
