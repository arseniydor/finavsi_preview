//
//  AppRouter.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import Combine
import SwiftUI

enum AppTab: Hashable {
    case dashboard
    case transactions
}

enum AppRoute: Hashable {
    case addTransaction
    case editTransaction(Transaction)
}

@MainActor
final class AppRouter: ObservableObject {
    @Published var selectedTab: AppTab = .dashboard

    @Published var dashboardPath: [AppRoute] = []
    @Published var transactionsPath: [AppRoute] = []

    func navigate(to route: AppRoute) {
        switch selectedTab {
        case .dashboard:
            dashboardPath.append(route)
        case .transactions:
            transactionsPath.append(route)
        }
    }
    
    func back() {
        switch selectedTab {
        case .dashboard:
            guard !dashboardPath.isEmpty else { return }
            dashboardPath.removeLast()
        case .transactions:
            guard !transactionsPath.isEmpty else { return }
            transactionsPath.removeLast()
        }
    }

    func popToRoot() {
        switch selectedTab {
        case .dashboard:
            dashboardPath.removeAll()
        case .transactions:
            transactionsPath.removeAll()
        }
    }
}
