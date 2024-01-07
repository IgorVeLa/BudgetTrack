//
//  ExpenseRowView.swift
//  BudgetTrack
//
//  Created by Igor L on 09/12/2023.
//


import Foundation
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
                        Text(String(entry.date.getYear()))
                    }
                }
            }
        }
    }
}

//#Preview {
//    ExpenseRowView(item: Entry(name: "Test", amount: 12.50, type: .expense, date: Date.now),
//                   selectedMonth: "December")
//}
