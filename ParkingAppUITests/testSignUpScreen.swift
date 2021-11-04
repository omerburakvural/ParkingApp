//
//  testSignUpScreen.swift
//  ParkingAppUITests
//
//  Created by PCMACEGITIM on 4.11.2021.
//

import XCTest

class testSignUpScreen: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
        XCUIApplication().launch()
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testKayitolNameTextBox() throws {
        let app = XCUIApplication()
        app.launch()
        
        let signupButton = app.buttons["Üye Ol"]
        signupButton.tap()
        let isim = app.textFields["Name"]
        let soyisim = app.textFields["Surname"]
        let email = app.textFields["Email"]
        let password = app.secureTextFields["Password"]
        let password_confirm = app.secureTextFields["Password Confirm"]
        let kaydol = app.buttons.element(boundBy: 0)
        XCTAssertTrue(isim.isEnabled)
        XCTAssertEqual(isim.exists, true)
        
        XCTAssertTrue(soyisim.isEnabled)
        XCTAssertEqual(soyisim.exists, true)
        
        XCTAssertTrue(email.isEnabled)
        XCTAssertEqual(email.exists, true)
        email.tap()
        sleep(2)
        
        XCTAssertEqual(password.exists, true)
        XCTAssertTrue(password.isEnabled)
        
        XCTAssertEqual(password_confirm.exists, true)
        XCTAssertTrue(password_confirm.isEnabled)
        kaydol.tap()
        
    }
    

}
