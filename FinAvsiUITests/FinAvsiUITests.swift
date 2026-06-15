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
            app.navigationBars["Dashboard"].waitForExistence(timeout: 3)
        )
    }

    @MainActor
    func testCreateTransaction() throws {
        app.buttons["addTransactionButton"].tap()

        XCTAssertTrue(
            app.navigationBars["Add Transaction"].waitForExistence(timeout: 3)
        )

        let titleField = app.textFields["transactionTitleField"]
        XCTAssertTrue(titleField.exists)
        titleField.tap()
        titleField.typeText("Coffee")

        let amountField = app.textFields["transactionAmountField"]
        XCTAssertTrue(amountField.exists)
        amountField.tap()
        amountField.typeText("4.5")

        let categoryField = app.textFields["transactionCategoryField"]
        XCTAssertTrue(categoryField.exists)
        categoryField.tap()
        categoryField.typeText("Food")

        app.buttons["saveTransactionButton"].tap()

        let dashboard = app.collectionViews["dashboardScreen"]
        XCTAssertTrue(dashboard.waitForExistence(timeout: 5))

        dashboard.swipeUp()

        XCTAssertTrue(
            app.staticTexts["Coffee"]
                .waitForExistence(timeout: 5)
        )
    }
}
