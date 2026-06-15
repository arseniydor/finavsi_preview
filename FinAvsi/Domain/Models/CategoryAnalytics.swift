//
//  CategoryAnalytics.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

struct CategoryAnalytics: Identifiable, Hashable {
    let id = UUID()
    let category: String
    let amount: Double
    let transactionCount: Int
}
