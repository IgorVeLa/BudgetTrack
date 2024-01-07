//
//  Entry.swift
//  BudgetTrack
//
//  Created by Igor L on 09/12/2023.
//


import Foundation
import SwiftData
import SwiftUI


enum EntryType: String, CaseIterable, Identifiable, Codable {
    case expense, income
    var id: Self { self }
}

@Model
class Entry {
    var id = UUID()
    var name: String
    var amount: Double
    var type: EntryType
    var date: Date
    
    init(id: UUID = UUID(), name: String, amount: Double, type: EntryType, date: Date) {
        self.id = id
        self.name = name
        self.amount = amount
        self.type = type
        self.date = date
    }
}
