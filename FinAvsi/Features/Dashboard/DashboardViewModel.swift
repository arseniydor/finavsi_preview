//
//  DashboardViewModel.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftUI
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {

    @Published private(set) var state: CommonViewState<[Transaction]> = .loading
    @Published var searchText: String = ""
    @Published var selectedType: TransactionType?

    private var allTransactions: [Transaction] = []
    private var hasLoaded = false

    private let fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol
    private let deleteTransactionUseCase: DeleteTransactionUseCaseProtocol

    init(
        fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol,
        deleteTransactionUseCase: DeleteTransactionUseCaseProtocol
    ) {
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
            allTransactions = try fetchTransactionsUseCase.execute()
            applyFilters()
        } catch {
            state = .error(message: "Failed to fetch transactions")
        }
    }

    func delete(_ transaction: Transaction) {
        do {
            try deleteTransactionUseCase.execute(id: transaction.id)
            allTransactions.removeAll { $0.id == transaction.id }
            applyFilters()
        } catch {
            state = .error(message: "Failed to delete transaction")
        }
    }

    func applyFilters() {
        var result = allTransactions

        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let query = searchText.lowercased()

            result = result.filter {
                $0.title.lowercased().contains(query)
                || ($0.description?.lowercased().contains(query) ?? false)
                || $0.category.lowercased().contains(query)
            }
        }

        if let selectedType {
            result = result.filter {
                $0.type == selectedType
            }
        }

        state = .loaded(result)
    }

    var totalExpenses: Double {
        allTransactions
            .filter { $0.type == .expense }
            .map(\.amount)
            .reduce(0, +)
    }

    var totalIncome: Double {
        allTransactions
            .filter { $0.type == .income }
            .map(\.amount)
            .reduce(0, +)
    }

    var balance: Double {
        totalIncome - totalExpenses
    }
}
