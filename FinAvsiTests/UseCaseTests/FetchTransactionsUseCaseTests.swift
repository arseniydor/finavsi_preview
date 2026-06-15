//
//  FetchTransactionsUseCaseTests.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Testing
@testable import FinAvsi
import Foundation

struct FetchTransactionsUseCaseTests {

    @Test
    func returnsTransactions() throws {
        let transaction = Transaction.mock(title: "Coffee")

        let repository = MockTransactionRepository(
            transactions: [transaction]
        )

        let useCase = FetchTransactionsUseCase(
            repository: repository
        )

        let result = try useCase.execute()

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func returnsEmptyArrayWhenRepositoryIsEmpty() throws {
        let repository = MockTransactionRepository()
        let useCase = FetchTransactionsUseCase(repository: repository)

        let result = try useCase.execute()

        #expect(result.isEmpty)
    }

    @Test
    func throwsRepositoryError() {
        let repository = MockTransactionRepository()
        repository.errorToThrow =
            TransactionRepositoryError.transactionNotFound

        let useCase = FetchTransactionsUseCase(
            repository: repository
        )

        #expect(throws: TransactionRepositoryError.self) {
            try useCase.execute()
        }
    }
}
