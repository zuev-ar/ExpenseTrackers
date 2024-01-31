//
//  ContentView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 02.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TransactionViewModel())
    }
}
