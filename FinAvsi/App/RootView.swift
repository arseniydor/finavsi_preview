//
//  RootView.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import SwiftUI

struct RootView: View {

    @StateObject private var router = AppRouter()

    let container: AppContainer

    var body: some View {
        TabView(selection: $router.selectedTab) {
            TabNavigationView(
                path: $router.dashboardPath,
                tabTitle: "Dashboard",
                tabImage: "chart.pie",
                tag: AppTab.dashboard,
                root: DashboardView(
                    viewModel: container.makeDashboardViewModel()
                ),
                destination: destination
            )
            
            TabNavigationView(
                path: $router.transactionsPath,
                tabTitle: "Transactions",
                tabImage: "list.bullet",
                tag: AppTab.transactions,
                root: TransactionsView(
                    viewModel: container.makeTransactionsViewModel()
                ),
                destination: destination
            )
        }
        .environmentObject(router)
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .addTransaction:
            AddTransactionView(viewModel: container.makeAddTransactionViewModel())
        case .editTransaction(let transaction):
            EditTransactionView(viewModel: container.makeEditTransactionViewModel(transaction: transaction))
        }
    }
}

