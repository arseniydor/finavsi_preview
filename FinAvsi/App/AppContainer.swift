//
//  AppContainer.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftData

@MainActor
final class AppContainer {

    private let transactionRepository: TransactionRepositoryProtocol

    private let fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol
    private let addTransactionUseCase: AddTransactionUseCaseProtocol
    private let updateTransactionUseCase: UpdateTransactionUseCaseProtocol
    private let deleteTransactionUseCase: DeleteTransactionUseCaseProtocol
    private let fetchDashboardAnalyticsUseCase: FetchDashboardAnalyticsUseCaseProtocol

    init(modelContext: ModelContext) {
        self.transactionRepository = TransactionRepository(context: modelContext)

        self.fetchTransactionsUseCase = FetchTransactionsUseCase(repository: transactionRepository)
        self.addTransactionUseCase = AddTransactionUseCase(repository: transactionRepository)
        self.updateTransactionUseCase = UpdateTransactionUseCase(repository: transactionRepository)
        self.deleteTransactionUseCase = DeleteTransactionUseCase(repository: transactionRepository)
        self.fetchDashboardAnalyticsUseCase = FetchDashboardAnalyticsUseCase(repository: transactionRepository)
    }

    @MainActor
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(fetchDashboardAnalyticsUseCase: fetchDashboardAnalyticsUseCase)
    }
    
    @MainActor
    func makeTransactionsViewModel() -> TransactionsViewModel {
        TransactionsViewModel(fetchTransactionsUseCase: fetchTransactionsUseCase, deleteTransactionUseCase: deleteTransactionUseCase)
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
