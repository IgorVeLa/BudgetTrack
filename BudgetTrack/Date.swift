//
//  Date.swift
//  BudgetTrack
//
//  Created by Igor L on 11/12/2023.
//


import Foundation
import SwiftUI


extension Date {
    func getMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: self)

        return monthString
    }
}
