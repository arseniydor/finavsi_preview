//
//  Transaction.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation

struct Transaction: Identifiable, Hashable, Codable {
    let id: UUID
    var amount: Double
    var type: TransactionType
    var category: String
    var title: String
    var description: String?
    var paymentMethod: PaymentMethod
    var date: Date
    var createdAt: Date
    var updatedAt: Date
}

extension Transaction {
    init(draft: TransactionDraft) {
        self.id = UUID()
        self.amount = draft.amount
        self.type = draft.type
        self.category = draft.category
        self.title = draft.title
        self.description = draft.description
        self.paymentMethod = draft.paymentMethod
        self.date = draft.date
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
extension Transaction {
    init(existing transaction: Transaction, draft: TransactionDraft) {
        self.id = transaction.id
        self.amount = draft.amount
        self.type = draft.type
        self.category = draft.category
        self.title = draft.title
        self.description = draft.description
        self.paymentMethod = draft.paymentMethod
        self.date = draft.date
        self.createdAt = transaction.createdAt
        self.updatedAt = Date()
    }
}
