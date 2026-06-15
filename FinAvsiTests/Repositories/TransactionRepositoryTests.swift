//
//  TransactionRepositoryTests.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Testing
@testable import FinAvsi
import Foundation

@MainActor
struct TransactionRepositoryTests {

    @Test
    func saveAddsTransaction() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(.mock(title: "Coffee"))

        let result = try fixture.repository.fetchAll()

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func fetchByIdReturnsTransaction() throws {
        let fixture = TestTransactionRepositoryFixture()

        let transaction = Transaction.mock(title: "Coffee")

        try fixture.repository.save(transaction)

        let result = try fixture.repository.fetch(id: transaction.id)

        #expect(result?.id == transaction.id)
        #expect(result?.title == "Coffee")
    }

    @Test
    func fetchByIdReturnsNilWhenNotFound() throws {
        let fixture = TestTransactionRepositoryFixture()

        let result = try fixture.repository.fetch(id: UUID())

        #expect(result == nil)
    }

    @Test
    func updateChangesTransaction() throws {
        let fixture = TestTransactionRepositoryFixture()

        let original = Transaction.mock(title: "Coffee")
        try fixture.repository.save(original)

        var updated = original
        updated.title = "Flat White"

        try fixture.repository.update(updated)

        let result = try fixture.repository.fetch(id: original.id)

        #expect(result?.title == "Flat White")
    }

    @Test
    func updateThrowsWhenTransactionNotFound() {
        let fixture = TestTransactionRepositoryFixture()
        let transaction = Transaction.mock(title: "Coffee")

        #expect(throws: TransactionRepositoryError.self) {
            try fixture.repository.update(transaction)
        }
    }

    @Test
    func deleteRemovesTransaction() throws {
        let fixture = TestTransactionRepositoryFixture()

        let transaction = Transaction.mock(title: "Coffee")
        try fixture.repository.save(transaction)

        try fixture.repository.delete(id: transaction.id)

        let result = try fixture.repository.fetchAll()

        #expect(result.isEmpty)
    }

    @Test
    func deleteThrowsWhenTransactionNotFound() {
        let fixture = TestTransactionRepositoryFixture()

        #expect(throws: TransactionRepositoryError.self) {
            try fixture.repository.delete(id: UUID())
        }
    }

    @Test
    func deleteAllRemovesAllTransactions() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(.mock(title: "Coffee"))
        try fixture.repository.save(.mock(title: "Taxi"))

        try fixture.repository.deleteAll()

        let result = try fixture.repository.fetchAll()

        #expect(result.isEmpty)
    }
}
