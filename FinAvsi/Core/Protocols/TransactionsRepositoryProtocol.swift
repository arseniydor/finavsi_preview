//
//  TransactionsRepositoryProtocol.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation

protocol TransactionRepositoryProtocol {
    func save(_ transaction: Transaction) throws
    func update(_ transaction: Transaction) throws
    func fetchAll() throws -> [Transaction]
    func fetch(id: UUID) throws -> Transaction?
    func fetch(filter: TransactionFilter) throws -> [Transaction]
    func delete(id: UUID) throws
    func deleteAll() throws
}
