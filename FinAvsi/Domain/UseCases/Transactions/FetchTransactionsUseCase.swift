//
//  FetchTransactionsUseCase.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Foundation

final class FetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {

    private let repository: TransactionRepositoryProtocol

    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    func execute() throws -> [Transaction] {
        try repository.fetchAll()
    }
    
    func execute(filter: TransactionFilter) throws -> [Transaction] {
        try repository.fetch(filter: filter)
    }
}
