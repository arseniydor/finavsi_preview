//
//  TransactionFilterTests.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Testing
@testable import FinAvsi
import Foundation

@MainActor
struct TransactionFilterTests {

    @Test
    func filtersTransactionsByType() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(.mock(type: .expense, title: "Coffee"))
        try fixture.repository.save(.mock(type: .income, title: "Salary"))

        let result = try fixture.repository.fetch(
            filter: TransactionFilter(type: .expense)
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func filtersTransactionsByPaymentMethod() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(
            .mock(title: "Coffee", paymentMethod: .card)
        )

        try fixture.repository.save(
            .mock(title: "Rent", paymentMethod: .cash)
        )

        let result = try fixture.repository.fetch(
            filter: TransactionFilter(paymentMethod: .card)
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func filtersTransactionsBySearchTextInTitle() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(.mock(title: "Coffee", category: "Food"))
        try fixture.repository.save(.mock(title: "Taxi", category: "Transport"))

        let result = try fixture.repository.fetch(
            filter: TransactionFilter(searchText: "cof")
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func filtersTransactionsBySearchTextInCategory() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(.mock(title: "Coffee", category: "Food"))
        try fixture.repository.save(.mock(title: "Taxi", category: "Transport"))

        let result = try fixture.repository.fetch(
            filter: TransactionFilter(searchText: "trans")
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Taxi")
    }

    @Test
    func filtersTransactionsByDateRange() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(
            .mock(title: "Old", date: Date(timeIntervalSince1970: 100))
        )

        try fixture.repository.save(
            .mock(title: "Recent", date: Date(timeIntervalSince1970: 300))
        )

        let result = try fixture.repository.fetch(
            filter: TransactionFilter(
                startDate: Date(timeIntervalSince1970: 200),
                endDate: Date(timeIntervalSince1970: 400)
            )
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Recent")
    }

    @Test
    func filtersTransactionsByAmountRange() throws {
        let fixture = TestTransactionRepositoryFixture()

        try fixture.repository.save(.mock(amount: 3, title: "Coffee"))
        try fixture.repository.save(.mock(amount: 80, title: "Dinner"))

        let result = try fixture.repository.fetch(
            filter: TransactionFilter(
                minAmount: 10,
                maxAmount: 100
            )
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Dinner")
    }
}
