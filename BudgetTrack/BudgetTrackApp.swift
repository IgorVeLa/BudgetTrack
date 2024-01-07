//
//  BudgetTrackApp.swift
//  BudgetTrack
//
//  Created by Igor L on 05/12/2023.
//


import SwiftData
import SwiftUI


@main
struct BudgetTrackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Entry.self)
    }
}
