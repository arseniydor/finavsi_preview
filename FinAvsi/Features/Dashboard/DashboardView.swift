//
//  DashboardView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Combine
import SwiftUI

struct DashboardView: View {

    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Dashboard")
            .accessibilityIdentifier("dashboardScreen")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        router.navigate(to: .addTransaction)
                    } label: {
                        Image(systemName: "plus")
                    }.accessibilityIdentifier("addTransactionButton")
                }
            }
            .task {
                await viewModel.initialLoad()
            }
            .onChange(of: router.dashboardPath) { _, newValue in
                if newValue.isEmpty {
                    Task {
                        await viewModel.reload()
                    }
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()

        case .loaded(let transactions):
            List {
                analyticsSection
                filtersSection

                Section("Transactions") {
                    ForEach(transactions) { transaction in
                        Button {
                            router.navigate(
                                to: .editTransaction(transaction)
                            )
                        } label: {
                            TransactionRowView(transaction: transaction)
                        }
                        .buttonStyle(.plain)
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.delete(transaction)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                            Button {
                                router.navigate(
                                    to: .editTransaction(transaction)
                                )
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .accessibilityIdentifier("transactionsList")

        case .error(let message):
            Text(message)
        }
    }

    private var analyticsSection: some View {
        Section("Summary") {
            HStack {
                VStack(alignment: .leading) {
                    Text("Income")
                    Text(viewModel.totalIncome, format: .currency(code: "EUR"))
                        .bold()
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Expenses")
                    Text(viewModel.totalExpenses, format: .currency(code: "EUR"))
                        .bold()
                }
            }

            HStack {
                Text("Balance")
                Spacer()
                Text(viewModel.balance, format: .currency(code: "EUR"))
                    .bold()
            }
        }
    }

    private var filtersSection: some View {
        Section("Filters") {
            TextField("Search", text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) {
                    viewModel.applyFilters()
                }

            Picker("Type", selection: $viewModel.selectedType) {
                Text("All").tag(TransactionType?.none)
                Text("Expense").tag(TransactionType?.some(.expense))
                Text("Income").tag(TransactionType?.some(.income))
            }
            .onChange(of: viewModel.selectedType) {
                viewModel.applyFilters()
            }
        }
    }
}
