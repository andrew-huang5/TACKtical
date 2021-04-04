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

    
    
    func testExample() {
        let app = XCUIApplication()
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 5).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        app.buttons["Horse"].tap()
        
        let riderProfilesButton = app.buttons["Rider Profiles"]
        riderProfilesButton.tap()
        
        let horseProfileButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.buttons["Horse Profile"]
        horseProfileButton.tap()
        riderProfilesButton.tap()
        horseProfileButton.tap()
        app.buttons["Edit Profile"].tap()
        
        let uploadButton = app.buttons["Upload"]
        uploadButton.tap()
        
        let newProfileButton = app.buttons["New Profile"]
        newProfileButton.tap()
        
        let horseProfileNavigationBar = app.navigationBars["Horse Profile"]
        let editProfileButton = horseProfileNavigationBar.buttons["Edit Profile"]
        editProfileButton.tap()
        
        let enterNewNameTextField = app.textFields["Enter new name"]
        enterNewNameTextField.tap()
        uploadButton.tap()
        uploadButton.tap()
        newProfileButton.tap()
        editProfileButton.tap()
        enterNewNameTextField.tap()
        app.navigationBars["Edit Profile"].buttons["Horse Profile"].tap()
        
        let riderProfileButton = horseProfileNavigationBar.buttons["Rider Profile"]
        riderProfileButton.tap()
        
        let horseProfileButton2 = app.navigationBars["Rider Profile"].buttons["Horse Profile"]
        horseProfileButton2.tap()
        riderProfileButton.tap()
        horseProfileButton2.tap()
        horseProfileNavigationBar.buttons["TACKtical"]/*@START_MENU_TOKEN@*/.press(forDuration: 1.2);/*[[".tap()",".press(forDuration: 1.2);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.buttons["Barn Data"].tap()
        app.launch()
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
