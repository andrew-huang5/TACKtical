//
//  TACKticalUITests.swift
//  TACKticalUITests
//
//  Created by Andrew Huang on 3/28/21.
//

import XCTest

class TACKticalUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let horseButton = app.buttons["Horse"]
        horseButton.tap()
        app.buttons["Upcoming Training Rides"].tap()
        app.buttons["Edit Profile"].tap()
        app.textFields["Enter new name"].tap()
        app.navigationBars["Edit Profile"].buttons["Horse Profile"].tap()
        
        let tackticalButton = app.navigationBars["Horse Profile"].buttons["TACKtical"]
        tackticalButton.tap()
        app.staticTexts["Schedule"].tap()
        horseButton.tap()
        tackticalButton.tap()
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
