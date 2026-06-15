//
//  MockTransactionRepository.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation
@testable import FinAvsi

final class MockTransactionRepository: TransactionRepositoryProtocol {

    var transactions: [Transaction]
    var errorToThrow: Error?

    init(transactions: [Transaction] = []) {
        self.transactions = transactions
    }

    func save(_ transaction: Transaction) throws {
        if let errorToThrow { throw errorToThrow }
        transactions.append(transaction)
    }

    func update(_ transaction: Transaction) throws {
        if let errorToThrow { throw errorToThrow }

        guard let index = transactions.firstIndex(where: { $0.id == transaction.id }) else {
            throw TransactionRepositoryError.transactionNotFound
        }

        transactions[index] = transaction
    }

    func fetchAll() throws -> [Transaction] {
        if let errorToThrow { throw errorToThrow }

        return transactions.sorted {
            $0.date > $1.date
        }
    }

    func fetch(id: UUID) throws -> Transaction? {
        if let errorToThrow { throw errorToThrow }

        return transactions.first {
            $0.id == id
        }
    }

    func fetch(filter: TransactionFilter) throws -> [Transaction] {
        if let errorToThrow { throw errorToThrow }

        return transactions
            .filter { transaction in
                matches(transaction, filter: filter)
            }
            .sorted {
                $0.date > $1.date
            }
    }

    func delete(id: UUID) throws {
        if let errorToThrow { throw errorToThrow }

        guard let index = transactions.firstIndex(where: { $0.id == id }) else {
            throw TransactionRepositoryError.transactionNotFound
        }

        transactions.remove(at: index)
    }

    func deleteAll() throws {
        if let errorToThrow { throw errorToThrow }

        transactions.removeAll()
    }
}

private extension MockTransactionRepository {

    func matches(
        _ transaction: Transaction,
        filter: TransactionFilter
    ) -> Bool {
        if let startDate = filter.startDate,
           transaction.date < startDate {
            return false
        }

        if let endDate = filter.endDate,
           transaction.date > endDate {
            return false
        }

        if let type = filter.type,
           transaction.type != type {
            return false
        }

        if let paymentMethod = filter.paymentMethod,
           transaction.paymentMethod != paymentMethod {
            return false
        }

        if let minAmount = filter.minAmount,
           transaction.amount < minAmount {
            return false
        }

        if let maxAmount = filter.maxAmount,
           transaction.amount > maxAmount {
            return false
        }

        if let searchText = filter.searchText,
           !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {

            let normalizedSearchText = searchText.lowercased()

            let titleMatches = transaction.title
                .lowercased()
                .contains(normalizedSearchText)

            let descriptionMatches = transaction.description?
                .lowercased()
                .contains(normalizedSearchText) ?? false

            let categoryMatches = transaction.category
                .lowercased()
                .contains(normalizedSearchText)

            if !titleMatches && !descriptionMatches && !categoryMatches {
                return false
            }
        }

        return true
    }
}
