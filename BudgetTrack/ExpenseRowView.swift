//
//  ExpenseRowView.swift
//  BudgetTrack
//
//  Created by Igor L on 09/12/2023.
//


import Foundation
import SwiftData
import SwiftUI


struct ExpenseRowView: View {
    var entry: Entry
    var selectedMonth: String
    var selectedYear: Int

    var body: some View {
        Group {
            if entry.date.getMonthString() == selectedMonth && entry.date.getYear() == selectedYear  {
                HStack {
                    VStack {
                        Text(entry.name)
                        Text(entry.type.rawValue)
                    }

                    Spacer()

                    VStack {
                        Text(entry.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                        Text(entry.date, format: .dateTime.day().month())
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContext = try ModelContainer(for: Entry.self, configurations: config)
        let testData = Entry(name: "String", amount: 15.00, type: .expense, date: Date.now)
        
        return ExpenseRowView(entry: testData, selectedMonth: Date.now.getMonthString(), selectedYear: Date.now.getYear())
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
