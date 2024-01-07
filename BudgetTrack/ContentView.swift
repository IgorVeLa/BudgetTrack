//
//  ContentView.swift
//  BudgetTrack
//
//  Created by Igor L on 05/12/2023.
//


import SwiftUI


struct ContentView: View {
    @State private var entries = Entries()

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
                    ForEach(entries.items) { item in
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
                NavigationLink(value: entries) {
                    Text("Add expense")
                }
                .navigationDestination(for: Entries.self) { entries in
                    AddExpenseView(entries: entries)
                }
            }
            .navigationTitle("\(selectedMonth)")
        }
    }

    func deleteExpense(at offsets: IndexSet) {
        entries.items.remove(atOffsets: offsets)
    }

    func total(entries: Entries, selectedMonth: String) -> Double {
        var incomes = [Double]()
        var expenses = [Double]()

        for entry in entries.items {
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
