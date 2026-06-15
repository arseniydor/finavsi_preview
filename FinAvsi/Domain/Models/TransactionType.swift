//
//  TransactionType.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation

enum TransactionType: String, Codable, CaseIterable {
    case expense = "Expense"
    case income = "Income"
}
