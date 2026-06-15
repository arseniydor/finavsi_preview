//
//  FetchTransactionsUseCaseTests.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Testing
@testable import FinAvsi
import Foundation

@MainActor
struct FetchTransactionsUseCaseTests {

    @Test
    func returnsTransactions() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(.mock(title: "Coffee"))

        let useCase = FetchTransactionsUseCase(
            repository: fixture.repository
        )

        let result = try useCase.execute()

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func returnsTransactionsSortedByDateDescending() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(
            .mock(title: "Old", date: Date(timeIntervalSince1970: 100))
        )

        try fixture.repository.save(
            .mock(title: "New", date: Date(timeIntervalSince1970: 200))
        )

        let useCase = FetchTransactionsUseCase(
            repository: fixture.repository
        )

        let result = try useCase.execute()

        #expect(result.count == 2)
        #expect(result[0].title == "New")
        #expect(result[1].title == "Old")
    }

    @Test
    func returnsEmptyArrayWhenRepositoryIsEmpty() throws {
        let fixture = TestTransactionRepositoryFixture()

        let useCase = FetchTransactionsUseCase(
            repository: fixture.repository
        )

        let result = try useCase.execute()

        #expect(result.isEmpty)
    }
}
