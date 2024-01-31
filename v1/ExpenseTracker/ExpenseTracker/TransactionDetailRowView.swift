//
//  TransactionDetailRowView.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 28.06.2023.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionDetailRowView: View {
    var icon: FontAwesomeCode
    var title: String
    var text: String
    
    var body: some View {
        
        HStack(spacing: 12) {
            // MARK: Icon
            FontIcon.text(.awesome5Solid(code: icon), fontsize: 24, color: Color.icon)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Title
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // MARK: Text
                Text(text)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 8)
    }
}

struct TransactionDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailRowView(icon: .store, title: "Merchant", text: "Apple")
    }
}
