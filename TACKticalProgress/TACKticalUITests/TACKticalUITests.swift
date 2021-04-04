//
//  TACKticalUITests.swift
//  TACKticalUITests
//
//

import XCTest

var app: XCUIApplication!

extension XCUIApplication {
    var isDisplayingHorse: Bool {
        return otherElements["HorseView"].exists
    }
}

extension XCUIApplication {
    var isDisplayingRider: Bool {
        return otherElements["RiderView"].exists
    }
}

extension XCUIApplication {
    var isDisplayingEdit: Bool {
        return otherElements["EditView"].exists
    }
}

class TACKticalUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        
        app.launchArguments.append("--UItesting")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        continueAfterFailure = false
    }

    func testProfile() {
        // UI tests must launch the application that they test.
        app.launch()
        
        XCTAssertTrue(app.isDisplayingHorse)
        XCTAssertFalse(app.isDisplayingRider)
        XCTAssertFalse(app.isDisplayingEdit)
        
        app.buttons["Rider Profile"].tap()
        
        XCTAssertTrue(app.isDisplayingRider)
        XCTAssertFalse(app.isDisplayingHorse)
        XCTAssertFalse(app.isDisplayingEdit)
        
        app.buttons["Horse Profile"].tap()
        
        XCTAssertTrue(app.isDisplayingHorse)
        XCTAssertFalse(app.isDisplayingRider)
        XCTAssertFalse(app.isDisplayingEdit)
        
        app.buttons["Edit Profile"].tap()
        
        XCTAssertTrue(app.isDisplayingEdit)
        XCTAssertFalse(app.isDisplayingHorse)
        XCTAssertFalse(app.isDisplayingRider)
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
