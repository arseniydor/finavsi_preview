//
//  FetchDashboardAnalyticsUseCase.swift
//  FinAvsi
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Foundation

final class FetchDashboardAnalyticsUseCase: FetchDashboardAnalyticsUseCaseProtocol {

    private let repository: TransactionRepositoryProtocol
    private let builder: DashboardAnalyticsBuilder

    init(repository: TransactionRepositoryProtocol, builder: DashboardAnalyticsBuilder = DashboardAnalyticsBuilder()) {
        self.repository = repository
        self.builder = builder
    }

    func execute(filter: TransactionFilter) throws -> DashboardAnalytics {
        let transactions = try repository.fetch(filter: filter)
        return builder.build(from: transactions)
    }
}
