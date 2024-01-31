//
//  TransactionNewView.swift
//  ExpenseTracker-Kavsoft
//
//  Created by zuev_ar on 07.07.2023.
//

import SwiftUI

struct TransactionNewView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    // MARK: Enviroment Values
    @Environment(\.self) var env
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("Add Transaction")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                
                // MARK: Custom TextField
                // For Currency Sybol
                if let symbol =
                    transactionVM.convertNumberToPrice(value: 0).first {
                    TextField("0", text: $transactionVM.amount)
                        .font(.system(size: 35))
                        .foregroundStyle(Color("Gradient2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background {
                            Text(transactionVM.amount == "" ? "0" : transactionVM.amount)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading) {
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                            
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top)
                    
                }
                
                // MARK: Custom Labels
                Label {
                    TextField("Remark", text: $transactionVM.remark)
                        .padding(.leading, 10)
                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundStyle(Color("Gray"))
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 20)
                
                Label {
                    // MARK: CheckBoxes
                    CustomCheckBoxesView()
                } icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundStyle(Color("Gray"))
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 20)
                
                Label {
                    DatePicker.init("",
                                    selection: $transactionVM.date,
                                    in: Date.distantPast...Date(),
                                    displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundStyle(Color("Gray"))
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 5)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            // MARK: Save Button
            
            Button {
                withAnimation {
                    transactionVM.saveData()
                }
                env.dismiss()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(colors: [
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3")
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
            }
            .padding(.vertical, 20)
            .disabled(transactionVM.remark == "" ||
                      transactionVM.type == .all ||
                      transactionVM.amount == "")
            .opacity(transactionVM.remark == "" ||
                      transactionVM.type == .all ||
                     transactionVM.amount == "" ? 0.6 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing) {
            // MARK: Close Button
            Button {
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .opacity(0.7)
            }
            .padding()
        }
    }
}

struct TransactionNew_Previews: PreviewProvider {
    static var previews: some View {
        TransactionNewView()
            .environmentObject(TransactionViewModel())
    }
}
