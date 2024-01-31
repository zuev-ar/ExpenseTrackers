//
//  CustomSegmentedControl.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 07.07.2023.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Namespace var animation
    @Binding var tabName: TransactionType
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach([TransactionType.income, TransactionType.expense], id: \.rawValue) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(tabName == tab ? .white : .black)
                    .opacity(tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        // MARK: With Matched Geometry Effect
                        if tabName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [Color("Gradient1"),
                                                 Color("Gradient2"),
                                                 Color("Gradient3")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            tabName = tab
                        }
                    }
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
}

struct CustomSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentedControl(tabName: .constant(.income))
    }
}
