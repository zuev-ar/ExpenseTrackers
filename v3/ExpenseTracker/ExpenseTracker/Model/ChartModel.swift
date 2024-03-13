//
//  ChartModel.swift
//  ExpenseTracker
//
//  Created by zuev_ar on 13.03.2024.
//

import SwiftUI

struct ChartGourp: Identifiable {
    let id: UUID = .init()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
}

struct ChartCategory: Identifiable {
    let id: UUID = .init()
    var totalValue: Double
    var category: Category
}
