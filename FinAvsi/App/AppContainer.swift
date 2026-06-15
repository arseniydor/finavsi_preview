//
//  AppContainer.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftData

final class AppContainer {

    private let transactionRepository: TransactionRepositoryProtocol

    private let fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol
    private let addTransactionUseCase: AddTransactionUseCaseProtocol
    private let updateTransactionUseCase: UpdateTransactionUseCaseProtocol
    private let deleteTransactionUseCase: DeleteTransactionUseCaseProtocol

    init(modelContext: ModelContext) {
        self.transactionRepository = TransactionRepository(context: modelContext)

        self.fetchTransactionsUseCase = FetchTransactionsUseCase(repository: transactionRepository)
        self.addTransactionUseCase = AddTransactionUseCase(repository: transactionRepository)
        self.updateTransactionUseCase = UpdateTransactionUseCase(repository: transactionRepository)
        self.deleteTransactionUseCase = DeleteTransactionUseCase(repository: transactionRepository)
    }

    @MainActor
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(fetchTransactionsUseCase: fetchTransactionsUseCase, deleteTransactionUseCase: deleteTransactionUseCase)
    }

    @MainActor
    func makeAddTransactionViewModel() -> AddTransactionViewModel {
        AddTransactionViewModel(addTransactionUseCase: addTransactionUseCase)
    }
    
    @MainActor
    func makeEditTransactionViewModel(transaction: Transaction) -> EditTransactionViewModel {
        EditTransactionViewModel(transaction: transaction, updateTransactionUseCase: updateTransactionUseCase)
    }
}
