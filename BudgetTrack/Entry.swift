//
//  Entry.swift
//  BudgetTrack
//
//  Created by Igor L on 09/12/2023.
//

import SwiftUI
import Foundation

enum EntryType: String, CaseIterable, Identifiable, Codable {
    case expense, income
    var id: Self { self }
}

struct Entry: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var amount: Double
    var type: EntryType
    var date: Date
}

@Observable
class Entries {
    var items = [Entry]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Entry].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

extension Entries: Hashable {
    static func == (lhs: Entries, rhs: Entries) -> Bool {
        return lhs.items == rhs.items
    }


    func hash(into hasher: inout Hasher) {
        hasher.combine(items)
    }
}
