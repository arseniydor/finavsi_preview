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
}
