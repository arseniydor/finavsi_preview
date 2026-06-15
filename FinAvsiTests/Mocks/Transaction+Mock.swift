//
//  Transaction+Mock.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

@testable import FinAvsi
import Foundation

extension Transaction {

    static func mock(
        id: UUID = UUID(),
        amount: Double = 10,
        type: TransactionType = .expense,
        title: String = "Coffee",
        category: String = "Test Category",
        transactionDescription: String? = nil,
        paymentMethod: PaymentMethod = .card,
        date: Date = .now,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) -> Transaction {
        Transaction(
            id: id,
            amount: amount,
            type: type,
            category: category,
            title: title,
            description: transactionDescription,
            paymentMethod: paymentMethod,
            date: date,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
