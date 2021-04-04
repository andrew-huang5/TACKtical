// Group 3 - Andrew Huang, Haris Nashed, Maddie Pinard, Zhengkai Xie
// Emails: andrew.huang@vanderbilt.edu, haris.r.nashed@vanderbilt.edu,
//      zhengkai.xie@vanderbilt.edu, madeleine.j.pinard@vanderbilt.edu
// Homework 4
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
        
        //this test method tests the navigation of the application as the user clicks through the various screens
        let horseButton = app.buttons["Horse"]
        horseButton.tap()
        XCTAssertTrue(app.buttons["Upcoming Training Rides"].exists)
        app.buttons["Upcoming Training Rides"].tap()
        XCTAssertTrue(app.buttons["Edit Profile"].exists)
        app.buttons["Edit Profile"].tap()
        XCTAssertTrue(app.textFields["Enter new name"].exists)
        app.textFields["Enter new name"].tap()
        XCTAssertTrue(app.navigationBars["Edit Profile"].buttons["Horse Profile"].exists)
        app.navigationBars["Edit Profile"].buttons["Horse Profile"].tap()

        let tackticalButton = app.navigationBars["Horse Profile"].buttons["TACKtical"]
        XCTAssertTrue(tackticalButton.exists)
        tackticalButton.tap()
        XCTAssertTrue(app.staticTexts["Schedule"].exists)
        app.staticTexts["Schedule"].tap()
        XCTAssertTrue(horseButton.exists)
        horseButton.tap()
        XCTAssertTrue(tackticalButton.exists)
        tackticalButton.tap()
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testBarnDataDropDowns() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().buttons["Barn Data"].tap()
        
        app.staticTexts["Horse Name"].tap()
        app.buttons["Mayor"].tap()
        app.navigationBars["Horse Profile"].buttons["Barn Data"].tap()
        app.images["chevron.up"].tap()
        
        app.staticTexts["Rider Name"].tap()
        app.buttons["Mayor"].tap()
        app.navigationBars["Horse Profile"].buttons["Barn Data"].tap()
        app.images["chevron.up"].tap()
        
        app.staticTexts["Instructor Name"].tap()
        app.buttons["Mayor"].tap()
        app.navigationBars["Horse Profile"].buttons["Barn Data"].tap()
        app.images["chevron.up"].tap()
                
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
