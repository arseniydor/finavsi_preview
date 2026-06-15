//
//  AddTransactionUseCase.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

final class AddTransactionUseCase: AddTransactionUseCaseProtocol {
    
    private let repository: TransactionRepositoryProtocol
    
    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    func execute(transaction: Transaction) throws {
        try repository.save(transaction)
    }
}
