//
//  DashboardView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Combine
import SwiftUI

struct DashboardView: View {

    @StateObject private var viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle("Dashboard")
            .task {
                await viewModel.initialLoad()
            }
            .onAppear {
                Task {
                    await viewModel.reload()
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()

        case .loaded(let analytics):
            List {
                Section {
                    MonthSwitcherView(
                        title: viewModel.selectedMonthTitle,
                        onPrevious: {
                            viewModel.previousMonth()
                        },
                        onNext: {
                            viewModel.nextMonth()
                        }
                    )
                }.buttonStyle(.borderless)

                Section("Summary") {
                    SummaryRowView(
                        title: "Income",
                        value: analytics.totalIncome
                    )

                    SummaryRowView(
                        title: "Expenses",
                        value: analytics.totalExpenses
                    )

                    SummaryRowView(
                        title: "Balance",
                        value: analytics.balance
                    )
                }

                Section("Overview") {
                    HStack {
                        Text("Transactions")
                        Spacer()
                        Text("\(analytics.transactionCount)")
                            .bold()
                    }

                    SummaryRowView(
                        title: "Average Expense",
                        value: analytics.averageExpense
                    )

                    if let topCategory = analytics.topCategory {
                        HStack {
                            Text("Top Category")
                            Spacer()

                            VStack(alignment: .trailing) {
                                Text(topCategory.category)
                                    .bold()

                                Text(
                                    topCategory.amount,
                                    format: .currency(code: "EUR")
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                Section("Categories") {
                    if analytics.categoryAnalytics.isEmpty {
                        Text("No expense data for this month")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(analytics.categoryAnalytics) { item in
                            CategoryAnalyticsRowView(item: item)
                        }
                    }
                }
            }

        case .error(let message):
            Text(message)
        }
    }
}
