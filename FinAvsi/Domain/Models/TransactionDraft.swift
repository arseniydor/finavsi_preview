//
//  TransactionDraft.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

struct TransactionDraft {
    var amount: Double = 0
    var type: TransactionType = .expense
    var category: String = ""
    var title: String = ""
    var description: String? = nil
    var paymentMethod: PaymentMethod = .card
    var date: Date = .now
}
extension TransactionDraft {
    init(transaction: Transaction) {
        self.amount = transaction.amount
        self.type = transaction.type
        self.category = transaction.category
        self.title = transaction.title
        self.description = transaction.description
        self.paymentMethod = transaction.paymentMethod
        self.date = transaction.date
    }
}
