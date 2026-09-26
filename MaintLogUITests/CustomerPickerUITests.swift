import XCTest

final class CustomerPickerUITests: XCTestCase {
    @MainActor
    func testCustomersAppearAndCanBeSelected() {
        let app = XCUIApplication()
        app.launch()
        let create = app.buttons["Create new MainLog"].firstMatch
        XCTAssertTrue(create.waitForExistence(timeout: 10))
        create.tap()
        let picker = app.buttons["chooseCustomer"]
        XCTAssertTrue(picker.waitForExistence(timeout: 5))
        picker.tap()
        let airline = app.staticTexts["Aegean Airlines"].firstMatch
        XCTAssertTrue(airline.waitForExistence(timeout: 5))
        airline.tap()
        XCTAssertTrue(picker.staticTexts["Aegean Airlines"].exists)
        // Ponowne otwarcie również musi zachować dostęp do danych.
        picker.tap()
        XCTAssertTrue(app.staticTexts["Aegean Airlines"].firstMatch.waitForExistence(timeout: 5))
    }
}
