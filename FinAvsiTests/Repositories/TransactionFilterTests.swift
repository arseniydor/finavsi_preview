//
//  TransactionFilterTests.swift
//  FinAvsiTests
//
//  Created by Arsenii Dorogin on 15/06/2026.
//

import Testing
@testable import FinAvsi
import Foundation

struct TransactionFilterTests {

    @Test
    func filtersTransactionsByType() throws {
        let expense = Transaction.mock(
            type: .expense, title: "Coffee"
        )

        let income = Transaction.mock(
            type: .income, title: "Salary"
        )

        let repository = MockTransactionRepository(
            transactions: [expense, income]
        )

        let result = try repository.fetch(
            filter: TransactionFilter(type: .expense)
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func filtersTransactionsBySearchTextInTitle() throws {
        let coffee = Transaction.mock(
            title: "Coffee",
            category: "Food"
        )

        let taxi = Transaction.mock(
            title: "Taxi",
            category: "Transport"
        )

        let repository = MockTransactionRepository(
            transactions: [coffee, taxi]
        )

        let result = try repository.fetch(
            filter: TransactionFilter(searchText: "cof")
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Coffee")
    }

    @Test
    func filtersTransactionsBySearchTextInCategory() throws {
        let coffee = Transaction.mock(
            title: "Coffee",
            category: "Food"
        )

        let taxi = Transaction.mock(
            title: "Taxi",
            category: "Transport"
        )

        let repository = MockTransactionRepository(
            transactions: [coffee, taxi]
        )

        let result = try repository.fetch(
            filter: TransactionFilter(searchText: "trans")
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Taxi")
    }

    @Test
    func filtersTransactionsByDateRange() throws {
        let old = Transaction.mock(
            title: "Old",
            date: Date(timeIntervalSince1970: 100)
        )

        let recent = Transaction.mock(
            title: "Recent",
            date: Date(timeIntervalSince1970: 300)
        )

        let repository = MockTransactionRepository(
            transactions: [old, recent]
        )

        let result = try repository.fetch(
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
        let cheap = Transaction.mock(
            amount: 3, title: "Coffee"
        )

        let expensive = Transaction.mock(
            amount: 80, title: "Dinner"
        )

        let repository = MockTransactionRepository(
            transactions: [cheap, expensive]
        )

        let result = try repository.fetch(
            filter: TransactionFilter(
                minAmount: 10,
                maxAmount: 100
            )
        )

        #expect(result.count == 1)
        #expect(result.first?.title == "Dinner")
    }
}
