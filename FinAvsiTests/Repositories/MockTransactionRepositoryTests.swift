//
//  MockTransactionRepositoryTests.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Testing
@testable import FinAvsi
import Foundation

struct MockTransactionRepositoryTests {

    @Test
    func fetchAllReturnsTransactionsSortedByDateDescending() throws {
        let oldTransaction = Transaction.mock(
            title: "Old",
            date: Date(timeIntervalSince1970: 100)
        )

        let newTransaction = Transaction.mock(
            title: "New",
            date: Date(timeIntervalSince1970: 200)
        )

        let repository = MockTransactionRepository(
            transactions: [
                oldTransaction,
                newTransaction
            ]
        )

        let result = try repository.fetchAll()

        #expect(result.count == 2)
        #expect(result[0].title == "New")
        #expect(result[1].title == "Old")
    }

    @Test
    func saveAddsTransaction() throws {
        let repository = MockTransactionRepository()
        let transaction = Transaction.mock(title: "Coffee")

        try repository.save(transaction)

        let result = try repository.fetchAll()

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func updateChangesTransaction() throws {
        let original = Transaction.mock(title: "Coffee")
        var updated = original
        updated.title = "Flat White"

        let repository = MockTransactionRepository(
            transactions: [original]
        )

        try repository.update(updated)

        let result = try repository.fetch(id: original.id)

        #expect(result?.title == "Flat White")
    }

    @Test
    func updateThrowsWhenTransactionNotFound() {
        let repository = MockTransactionRepository()
        let transaction = Transaction.mock(title: "Coffee")

        #expect(throws: TransactionRepositoryError.self) {
            try repository.update(transaction)
        }
    }

    @Test
    func deleteRemovesTransaction() throws {
        let transaction = Transaction.mock(title: "Coffee")

        let repository = MockTransactionRepository(
            transactions: [transaction]
        )

        try repository.delete(id: transaction.id)

        let result = try repository.fetchAll()

        #expect(result.isEmpty)
    }

    @Test
    func deleteThrowsWhenTransactionNotFound() {
        let repository = MockTransactionRepository()
        let id = UUID()

        #expect(throws: TransactionRepositoryError.self) {
            try repository.delete(id: id)
        }
    }

    @Test
    func deleteAllRemovesAllTransactions() throws {
        let repository = MockTransactionRepository(
            transactions: [
                .mock(title: "Coffee"),
                .mock(title: "Taxi")
            ]
        )

        try repository.deleteAll()

        let result = try repository.fetchAll()

        #expect(result.isEmpty)
    }

    @Test
    func fetchByIdReturnsTransaction() throws {
        let transaction = Transaction.mock(title: "Coffee")

        let repository = MockTransactionRepository(
            transactions: [transaction]
        )

        let result = try repository.fetch(id: transaction.id)

        #expect(result?.id == transaction.id)
        #expect(result?.title == "Coffee")
    }

    @Test
    func fetchByIdReturnsNilWhenNotFound() throws {
        let repository = MockTransactionRepository()

        let result = try repository.fetch(id: UUID())

        #expect(result == nil)
    }
}
