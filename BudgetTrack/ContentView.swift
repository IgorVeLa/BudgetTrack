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
    @State private var selectedMonth = Date.now.getMonthString()
    @State private var selectedYear = Date.now.getYear()
    let currentYear = Date.now.getYear()
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Spacer()
                    Picker("View month", selection: $selectedMonth) {
                        ForEach(months, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("View year", selection: $selectedYear) {
                        ForEach(2000...currentYear, id: \.self) {
                            Text(String($0))
                        }
                    }
                    Spacer()
                }
                .labelsHidden()
                
                Section {
                    ForEach(entries) { entry in
                        ExpenseRowView(entry: entry, selectedMonth: selectedMonth, selectedYear: selectedYear)
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
                    Text("\(Image(systemName: "plus"))")
                }

            }
            .navigationTitle(Text(verbatim: "\(selectedMonth) \(selectedYear)"))
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
            if entry.type == .income && entry.date.getMonthString() == selectedMonth && entry.date.getYear() == selectedYear {
                incomes.append(entry.amount)
            } else if entry.type == .expense && entry.date.getMonthString() == selectedMonth && entry.date.getYear() == selectedYear  {
                expenses.append(entry.amount)
            }
        }


        return (incomes.reduce(0, +)) - (expenses.reduce(0, +))
    }
}

#Preview {
    ContentView()
}
