//
//  DashboardAnalyticsBuilder.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

final class DashboardAnalyticsBuilder {

    func build(from transactions: [Transaction]) -> DashboardAnalytics {

        let incomeTransactions = transactions.filter {
            $0.type == .income
        }

        let expenseTransactions = transactions.filter {
            $0.type == .expense
        }

        let totalIncome = incomeTransactions
            .map(\.amount)
            .reduce(0, +)

        let totalExpenses = expenseTransactions
            .map(\.amount)
            .reduce(0, +)

        let categoryAnalytics = buildCategoryAnalytics(
            from: expenseTransactions
        )

        let averageExpense = expenseTransactions.isEmpty
            ? 0
            : totalExpenses / Double(expenseTransactions.count)

        return DashboardAnalytics(
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
            balance: totalIncome - totalExpenses,
            transactionCount: transactions.count,
            averageExpense: averageExpense,
            topCategory: categoryAnalytics.first,
            categoryAnalytics: categoryAnalytics
        )
    }
}

// MARK: - Private

private extension DashboardAnalyticsBuilder {

    func buildCategoryAnalytics(from transactions: [Transaction]) -> [CategoryAnalytics] {

        let grouped = Dictionary(
            grouping: transactions,
            by: { $0.category }
        )

        return grouped
            .map { category, transactions in
                CategoryAnalytics(
                    category: category,
                    amount: transactions
                        .map(\.amount)
                        .reduce(0, +),
                    transactionCount: transactions.count
                )
            }
            .sorted {
                $0.amount > $1.amount
            }
    }
}
