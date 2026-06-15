//
//  TransactionEntity.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftData
import Foundation

@Model
final class TransactionEntity {
    
    @Attribute(.unique)
    var id: UUID
    
    var amount: Double
    var type: TransactionType
    var category: String
    var title: String
    var transactionDescription: String?
    var paymentMethod: PaymentMethod
    var date: Date
    var createdAt: Date
    var updatedAt: Date
    
    init(id: UUID, amount: Double, type: TransactionType, category: String, title: String, description: String? = nil, paymentMethod: PaymentMethod, date: Date, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.amount = amount
        self.type = type
        self.category = category
        self.title = title
        self.transactionDescription = description
        self.paymentMethod = paymentMethod
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
