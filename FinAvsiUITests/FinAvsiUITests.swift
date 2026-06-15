//
//  FinAvsiUITests.swift
//  FinAvsiUITests
//
//  Created by Arsenii Dorogin on 14/06/2026.
//

import XCTest

final class FinAvsiUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = [
            "-ui-testing"
        ]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testDashboardIsVisibleOnLaunch() throws {
        XCTAssertTrue(
            app.navigationBars["Dashboard"]
                .waitForExistence(timeout: 3)
        )
    }

    @MainActor
    func testTransactionsTabIsVisible() throws {
        app.tabBars.buttons["Transactions"].tap()

        XCTAssertTrue(
            app.navigationBars["Transactions"]
                .waitForExistence(timeout: 3)
        )
    }

    @MainActor
    func testCreateTransaction() throws {
        app.tabBars.buttons["Transactions"].tap()

        XCTAssertTrue(
            app.navigationBars["Transactions"]
                .waitForExistence(timeout: 3)
        )

        app.buttons["addTransactionButton"].tap()

        XCTAssertTrue(
            app.navigationBars["Add Transaction"]
                .waitForExistence(timeout: 3)
        )

        let titleField = app.textFields["transactionTitleField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 3))
        titleField.tap()
        titleField.typeText("Coffee")

        let amountField = app.textFields["transactionAmountField"]
        XCTAssertTrue(amountField.waitForExistence(timeout: 3))
        amountField.tap()
        amountField.typeText("4.5")

        let categoryField = app.textFields["transactionCategoryField"]
        XCTAssertTrue(categoryField.waitForExistence(timeout: 3))
        categoryField.tap()
        categoryField.typeText("Food")

        app.buttons["saveTransactionButton"].tap()

        XCTAssertTrue(
            app.navigationBars["Transactions"]
                .waitForExistence(timeout: 5)
        )

        let transactionsScreen = app.collectionViews["transactionsScreen"]
        XCTAssertTrue(
            transactionsScreen.waitForExistence(timeout: 5)
        )

        transactionsScreen.swipeUp()

        XCTAssertTrue(
            app.staticTexts["Coffee"]
                .waitForExistence(timeout: 5)
        )
    }
}
