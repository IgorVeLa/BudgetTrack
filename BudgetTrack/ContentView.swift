//
//  ContentView.swift
//  BudgetTrack
//
//  Created by Igor L on 05/12/2023.
//


import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var entries: [Entry]
    
    let months: [String] = Calendar.current.monthSymbols
    @State private var selectedMonth = "January"
    
    var body: some View {
        NavigationStack {
            List {
                Picker("View month", selection: $selectedMonth) {
                    ForEach(months, id: \.self) {
                        Text($0)
                    }
                }
                .labelsHidden()
                
                Section {
                    ForEach(entries) { item in
                        ExpenseRowView(item: item, selectedMonth: selectedMonth)
                    }
                    .onDelete(perform: deleteExpense)
                }
                
                Section {
                    HStack {
                        Text("Total: ")
                        Text(total(entries: entries, selectedMonth: selectedMonth), format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                    }
                }
            }
            .toolbar {
                NavigationLink {
                    AddExpenseView()
                } label: {
                    Text("Add expense")
                }

            }
            .navigationTitle("\(selectedMonth)")
        }
    }
    
    func deleteExpense(at offsets: IndexSet) {
        for offset in offsets {
            let entry = entries[offset]
            
            modelContext.delete(entry)
        }
    }
    
    func total(entries: [Entry], selectedMonth: String) -> Double {
        var incomes = [Double]()
        var expenses = [Double]()
        
        for entry in entries {
            if entry.type == .income && entry.date.getMonthString() == selectedMonth {
                incomes.append(entry.amount)
            } else if entry.type == .expense && entry.date.getMonthString() == selectedMonth {
                expenses.append(entry.amount)
            }
        }

        return (incomes.reduce(0, +)) - (expenses.reduce(0, +))
    }
}

#Preview {
    ContentView()
}
