//
//  TransactionFilter.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation

struct TransactionFilter {
    var startDate: Date?
    var endDate: Date?
    var type: TransactionType?
    var searchText: String?
    var paymentMethod: PaymentMethod?
    var minAmount: Double?
    var maxAmount: Double?
}
