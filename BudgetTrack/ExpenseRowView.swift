//
//  ExpenseRowView.swift
//  BudgetTrack
//
//  Created by Igor L on 09/12/2023.
//


import Foundation
import SwiftUI


struct ExpenseRowView: View {
    var item: Entry
    var selectedMonth: String

    var body: some View {
        Group {
            if item.date.getMonthString() == selectedMonth {
                HStack {
                    VStack {
                        Text(item.name)
                        Text(item.type.rawValue)
                    }

                    Spacer()

                    VStack {
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                        Text(item.date, format: .dateTime.day().month())
                    }
                }
            }
        }
    }
}

#Preview {
    ExpenseRowView(item: Entry(name: "Test", amount: 12.50, type: .expense, date: Date.now),
                   selectedMonth: "December")
}
