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

    //pre-requisite for running this function: ensure that current user is logged out
    func testlogin() throws {
        
        let app = XCUIApplication()
        app.buttons["Sign Up Now"].tap()
        
        //exiting sign up screen
        app.buttons["xmark"].tap()
        
        //re-enter + test new profile creation
        app.buttons["Sign Up Now"].tap()
        
        //checking that error message pops up if you haven't entered required fields
        app.buttons["SIGNUP"].tap()
        
        let okButton = app.alerts["Message"].scrollViews.otherElements.buttons["Ok"]
        okButton.tap()
        
        //filling in required fields, passwords don't match
        app.textFields["Name"].typeText("Maddie")
        app.textFields["Phone"].typeText("9789874416")
        app.textFields["Email"].typeText("mpianrd16cchs@gmail.com")
        app.secureTextFields["Password"].typeText("horses")
        app.secureTextFields["Re-Enter"].typeText("horses123")
        app.buttons["SIGNUP"].tap()
        
        // password mismatch error message displayed to user
        app.buttons["SIGNUP"].tap()
        app.alerts["Message"].scrollViews.otherElements.buttons["Ok"].tap()
        
        
        //testing that password must be 6 characters or more and error message is generated
        app.secureTextFields["Password"].typeText("123")
        app.secureTextFields["Re-Enter"].typeText("123")
        
        app.buttons["SIGNUP"].tap()
        app.alerts["Message"].scrollViews.otherElements.buttons["Ok"].tap()
        
        //enter passwords that match, account is created
        app.secureTextFields["Password"].typeText("horses")
        app.secureTextFields["Re-Enter"].typeText("horses")
        app.buttons["SIGNUP"].tap()
        app.alerts["Message"].scrollViews.otherElements.buttons["Ok"].tap()
        
        //brings you back to home screen - testing that log in works for authenticated account
        
        app.textFields["Email"].typeText("madeleine.j.pinard@vanderbilt.edu")
        app.secureTextFields["Password"].typeText("horses123")
        app.buttons["LOGIN"].tap()
        app.alerts["Message"].scrollViews.otherElements.buttons["Ok"].tap()
        
        
        //testing forgot password functionality
        app.alerts["Reset Password"].scrollViews.otherElements.buttons["Reset"].tap()
        okButton.tap()
    }
    
    //pre- requisite for this test: must be logged into home screen with authenticated user
    func testScrollProfile() throws {
        
        let app = XCUIApplication()
        app.buttons["HorseMenu"].tap()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.staticTexts["Email: madeleine.j.pinard@vanderbilt.edu"].swipeUp()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Maddie").element.swipeUp()
        elementsQuery.buttons["Student Profile"].tap()
        app.buttons["Calendar"].tap()
        app.buttons["Home"].tap()
    }
    // pre-requisite for this function is that there is a user-logged into the application
    func testlogout() throws {
        
        let app = XCUIApplication()
        app.buttons["LogOut"].tap()
        app.textFields["Email"].typeText("madeleine.j.pinard@vanderbilt.edu")
        app.secureTextFields["Password"].typeText("horses123")
        app.buttons["LOGIN"].tap()
    }
    
    func testcalendarnavigation() throws{
        
        let app = XCUIApplication()
        app.buttons["Calendar"].tap()
        app.buttons["arrow.right"].tap()
        app.buttons["arrow.left"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["13"]/*[[".cells.staticTexts[\"13\"]",".staticTexts[\"13\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
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

