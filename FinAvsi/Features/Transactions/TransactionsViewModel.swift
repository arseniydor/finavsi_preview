//
//  TransactionsViewModel.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Combine
import Foundation

@MainActor
final class TransactionsViewModel: ObservableObject {

    @Published private(set) var state: CommonViewState<[Transaction]> = .loading
    @Published var filter = TransactionFilter()

    private var hasLoaded = false

    private let fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol
    private let deleteTransactionUseCase: DeleteTransactionUseCaseProtocol

    init(fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol, deleteTransactionUseCase: DeleteTransactionUseCaseProtocol) {
        self.fetchTransactionsUseCase = fetchTransactionsUseCase
        self.deleteTransactionUseCase = deleteTransactionUseCase
    }

    func initialLoad() async {
        guard !hasLoaded else { return }
        await reload()
        hasLoaded = true
    }

    func reload() async {
        state = .loading

        do {
            let transactions = try fetchTransactionsUseCase.execute(
                filter: filter
            )
            state = .loaded(transactions)
        } catch {
            state = .error(message: "Failed to fetch transactions")
        }
    }

    func applyFilters() {
        Task {
            await reload()
        }
    }

    func resetFilters() {
        filter = TransactionFilter()
        Task {
            await reload()
        }
    }

    func delete(_ transaction: Transaction) {
        do {
            try deleteTransactionUseCase.execute(id: transaction.id)
            Task {
                await reload()
            }
        } catch {
            state = .error(message: "Failed to delete transaction")
        }
    }
}
