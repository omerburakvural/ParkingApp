//
//  ParkingAppUITests.swift
//  ParkingAppUITests
//
//  Created by Omer Burak Vural on 31.10.2021.
//

import XCTest


@testable import ParkingApp

class ParkingAppUITests: XCTestCase {
  
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSigninScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let emailTextbox = app.textFields["emailSignin"]
        let passwordTextbox = app.secureTextFields["Password"]
        let hideButton = app.buttons["hideButton"]
        let signinButton = app.buttons["Giriş"]
        
        XCTAssertTrue(emailTextbox.isEnabled, "Email girişi açıktır")
        XCTAssertTrue(emailTextbox.exists, "Email girişi mevcut")
        
        XCTAssertTrue(hideButton.exists, "Şifre gizleme butonu mevcut")
        XCTAssertTrue(hideButton.isEnabled)
        XCTAssertTrue(hideButton.isEnabled, "Gizleme butonu açık")
        XCTAssertTrue(passwordTextbox.isEnabled, "Parola giriş mevcut")
        
        XCTAssertTrue(signinButton.exists, "Kullanıcı giriş mevcut")
        XCTAssertTrue(signinButton.isEnabled, "Giriş butonu açık")
       
        emailTextbox.tap()
        emailTextbox.typeText("erademtest@gmail.iu")
        passwordTextbox.tap()
        passwordTextbox.typeText("123456")
        signinButton.tap()
        
        //        XCTAssertEqual(emailTextField.textContentType, UITextContentType.username, "Email address UITextField does not have an Email Address Content Type set")

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testSigninSwitch() throws
    {
        
        let app = XCUIApplication()
        app.launch()
        
        let `switch` = app.switches["benihatırla"]
        XCTAssertTrue(`switch`.isEnabled, "beni hatırla switch kullanılabilir durumda")
       
    }
    func testIcon() throws
    {
        
        let app = XCUIApplication()
        app.launch()
        
        let image = app.images["ikon"]
        XCTAssertTrue(image.exists, "İkon yerinde")
    }
    func testNoUserTextFieldExists() throws
    {
        
        let app = XCUIApplication()
        app.launch()
        
        let sifremiUnuttumButton = app.buttons["Şifremi Unuttum"]
        sifremiUnuttumButton.tap()
        let forgotpasswordtextbox = app.textFields["Email"]
        XCTAssertTrue(forgotpasswordtextbox.exists)
    }
    func testNoUserButtonExists() throws
    {
        
        let app = XCUIApplication()
        app.launch()
        
        let sifremiUnuttumButton = app.buttons["Şifremi Unuttum"]
        sifremiUnuttumButton.tap()
        let forgotPasswordSendButtton = app.buttons["sendButton"]
        XCTAssertTrue(forgotPasswordSendButtton.isEnabled)
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
