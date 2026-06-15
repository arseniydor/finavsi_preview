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

    @Published private(set) var state: CommonViewState<DashboardAnalytics> = .loading
    @Published private(set) var selectedMonth: Date = Date()

    private var hasLoaded = false
    private let fetchDashboardAnalyticsUseCase: FetchDashboardAnalyticsUseCaseProtocol
    private let calendar = Calendar.current

    init(fetchDashboardAnalyticsUseCase: FetchDashboardAnalyticsUseCaseProtocol) {
        self.fetchDashboardAnalyticsUseCase = fetchDashboardAnalyticsUseCase
    }

    func initialLoad() async {
        guard !hasLoaded else { return }
        await reload()
        hasLoaded = true
    }

    func reload() async {
        state = .loading

        do {
            let analytics = try fetchDashboardAnalyticsUseCase.execute(
                filter: makeMonthFilter()
            )
            state = .loaded(analytics)
        } catch {
            state = .error(message: "Failed to fetch analytics")
        }
    }

    func previousMonth() {
        selectedMonth = calendar.date(
            byAdding: .month,
            value: -1,
            to: selectedMonth
        ) ?? selectedMonth

        Task {
            await reload()
        }
    }

    func nextMonth() {
        selectedMonth = calendar.date(
            byAdding: .month,
            value: 1,
            to: selectedMonth
        ) ?? selectedMonth

        Task {
            await reload()
        }
    }

    var selectedMonthTitle: String {
        selectedMonth.formatted(
            .dateTime
                .month(.wide)
                .year()
        )
    }
}

// MARK: - Private

private extension DashboardViewModel {

    func makeMonthFilter() -> TransactionFilter {
        let startDate = calendar.date(
            from: calendar.dateComponents(
                [.year, .month],
                from: selectedMonth
            )
        )

        let endDate = startDate.flatMap {
            calendar.date(
                byAdding: .month,
                value: 1,
                to: $0
            )
        }

        return TransactionFilter(
            startDate: startDate,
            endDate: endDate,
            type: nil,
            searchText: nil,
            paymentMethod: nil,
            minAmount: nil,
            maxAmount: nil
        )
    }
}
