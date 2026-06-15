//
//  TransactionsView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import SwiftUI

struct TransactionsView: View {

    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel: TransactionsViewModel

    init(viewModel: TransactionsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        router.navigate(to: .addTransaction)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("addTransactionButton")
                }
            }
            .task {
                await viewModel.initialLoad()
            }
            .onChange(of: router.transactionsPath) { _, newValue in
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
            .accessibilityIdentifier("transactionsScreen")
            .scrollDismissesKeyboard(.interactively)

        case .error(let message):
            Text(message)
        }
    }

    private var filtersSection: some View {
        Section("Filters") {
            TextField(
                "Search",
                text: Binding(
                    get: {
                        viewModel.filter.searchText ?? ""
                    },
                    set: { newValue in
                        viewModel.filter.searchText = newValue.isEmpty ? nil : newValue
                        viewModel.applyFilters()
                    }
                )
            )

            Picker("Type", selection: $viewModel.filter.type) {
                Text("All").tag(TransactionType?.none)
                Text("Expense").tag(TransactionType?.some(.expense))
                Text("Income").tag(TransactionType?.some(.income))
            }
            .onChange(of: viewModel.filter.type) {
                viewModel.applyFilters()
            }

            Picker("Payment Method", selection: $viewModel.filter.paymentMethod) {
                Text("All").tag(PaymentMethod?.none)

                ForEach(PaymentMethod.allCases, id: \.self) { method in
                    Text(method.rawValue).tag(PaymentMethod?.some(method))
                }
            }
            .onChange(of: viewModel.filter.paymentMethod) {
                viewModel.applyFilters()
            }

            DatePicker(
                "Start Date",
                selection: Binding(
                    get: {
                        viewModel.filter.startDate ?? Calendar.current.date(
                            byAdding: .day,
                            value: -7,
                            to: Date()
                        ) ?? Date()
                    },
                    set: { newValue in
                        viewModel.filter.startDate = newValue
                        viewModel.applyFilters()
                    }
                ),
                displayedComponents: .date
            )

            DatePicker(
                "End Date",
                selection: Binding(
                    get: {
                        viewModel.filter.endDate ?? Date()
                    },
                    set: { newValue in
                        viewModel.filter.endDate = newValue
                        viewModel.applyFilters()
                    }
                ),
                displayedComponents: .date
            )

            Button("Reset Filters") {
                viewModel.resetFilters()
            }
        }
    }
}
