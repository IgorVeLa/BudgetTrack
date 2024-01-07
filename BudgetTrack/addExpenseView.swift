//
//  addExpenseView.swift
//  BudgetTrack
//
//  Created by Igor L on 08/12/2023.
//


import Foundation
import SwiftUI


struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    
    var entries: Entries
    
    @State private var name = ""
    @State private var amount = 0.0
    @State private var selectedType: EntryType = .expense
    @State private var date = Date.now
    

    var body: some View {
        List {
            Picker("Type", selection: $selectedType) {
                ForEach(EntryType.allCases) { entryType in
                    Text(entryType.rawValue)
                }
            }
            .pickerStyle(.segmented)

            DatePicker("Pick the date", selection: $date, displayedComponents: ([.date]))
                .labelsHidden()

            TextField("Name", text: $name)

            TextField("Amount", value: $amount, format: .currency(code: "GBP"))
                .keyboardType(.decimalPad)

        }
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    let item = Entry(name: name,
                                        amount: amount,
                                        type: selectedType,
                                        date: date)
                    entries.items.append(item)

                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("\(Image(systemName: "chevron.backward")) Cancel") {
                    dismiss()
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }

    func save() {
        dismiss()
    }
}

#Preview {
    AddExpenseView(entries: Entries())
}
