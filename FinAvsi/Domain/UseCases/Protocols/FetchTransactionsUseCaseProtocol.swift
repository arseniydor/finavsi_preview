//
//  FetchTransactionsUseCaseProtocol.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

protocol FetchTransactionsUseCaseProtocol {
    func execute() throws -> [Transaction]
    func execute(filter: TransactionFilter) throws -> [Transaction]
}
