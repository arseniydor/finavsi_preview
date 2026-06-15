//
//  TransactionRepository.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftData
import Foundation

final class TransactionRepository: TransactionRepositoryProtocol {

    private let context: ModelContext
    private let mapper: TransactionMapper

    init(
        context: ModelContext,
        mapper: TransactionMapper = TransactionMapper()
    ) {
        self.context = context
        self.mapper = mapper
    }

    func save(_ transaction: Transaction) throws {
        let entity = mapper.mapToEntity(transaction)
        context.insert(entity)
        try context.save()
    }

    func update(_ transaction: Transaction) throws {
        let id = transaction.id

        let descriptor = FetchDescriptor<TransactionEntity>(
            predicate: #Predicate { entity in
                entity.id == id
            }
        )

        guard let entity = try context.fetch(descriptor).first else {
            throw TransactionRepositoryError.transactionNotFound
        }

        mapper.updateEntity(entity, from: transaction)

        try context.save()
    }

    func fetchAll() throws -> [Transaction] {
        let descriptor = FetchDescriptor<TransactionEntity>(
            sortBy: [
                SortDescriptor(\.date, order: .reverse)
            ]
        )

        return try context
            .fetch(descriptor)
            .map { mapper.mapToDomain($0) }
    }

    func fetch(id: UUID) throws -> Transaction? {
        let descriptor = FetchDescriptor<TransactionEntity>(
            predicate: #Predicate { entity in
                entity.id == id
            }
        )

        return try context
            .fetch(descriptor)
            .first
            .map { mapper.mapToDomain($0) }
    }

    func fetch(filter: TransactionFilter) throws -> [Transaction] {
        let entities = try fetchFilteredEntities(filter: filter)

        return entities.map {
            mapper.mapToDomain($0)
        }
    }

    func delete(id: UUID) throws {
        let descriptor = FetchDescriptor<TransactionEntity>(
            predicate: #Predicate { entity in
                entity.id == id
            }
        )

        guard let entity = try context.fetch(descriptor).first else {
            throw TransactionRepositoryError.transactionNotFound
        }

        context.delete(entity)

        try context.save()
    }

    func deleteAll() throws {
        let descriptor = FetchDescriptor<TransactionEntity>()
        let entities = try context.fetch(descriptor)

        entities.forEach {
            context.delete($0)
        }

        try context.save()
    }
}

// MARK: - Private

private extension TransactionRepository {

    func fetchFilteredEntities(
        filter: TransactionFilter
    ) throws -> [TransactionEntity] {

        let descriptor = FetchDescriptor<TransactionEntity>(
            sortBy: [
                SortDescriptor(\.date, order: .reverse)
            ]
        )

        let entities = try context.fetch(descriptor)

        return entities.filter { entity in
            matches(entity, filter: filter)
        }
    }

    func matches(
        _ entity: TransactionEntity,
        filter: TransactionFilter
    ) -> Bool {

        if let startDate = filter.startDate,
           entity.date < startDate {
            return false
        }

        if let endDate = filter.endDate,
           entity.date > endDate {
            return false
        }

        if let type = filter.type,
           entity.type != type {
            return false
        }

        if let paymentMethod = filter.paymentMethod,
           entity.paymentMethod != paymentMethod {
            return false
        }

        if let minAmount = filter.minAmount {
            let amount = entity.amount

            if amount < minAmount {
                return false
            }
        }

        if let maxAmount = filter.maxAmount {
            let amount = entity.amount

            if amount > maxAmount {
                return false
            }
        }

        if let searchText = filter.searchText,
           !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {

            let normalizedSearchText = searchText.lowercased()

            let titleMatches = entity.title
                .lowercased()
                .contains(normalizedSearchText)

            let noteMatches = entity.transactionDescription?
                .lowercased()
                .contains(normalizedSearchText) ?? false

            if !titleMatches && !noteMatches {
                return false
            }
        }

        return true
    }
}
