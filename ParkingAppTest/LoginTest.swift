//
//  LoginTest.swift
//  ParkingAppTest
//
//  Created by PCMACEGITIM on 1.11.2021.
//

import XCTest
@testable import ParkingApp






class LoginTest: XCTestCase {
    var ekran: LoginViewController!
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    func testLoginPassworIsSecure() throws{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        ekran = storyboard.instantiateViewController(withIdentifier: "main") as? LoginViewController
           ekran.loadViewIfNeeded()
        let passwordtext = try XCTUnwrap(ekran.txtPassword, "Password textbox")
        XCTAssertTrue(passwordtext.isSecureTextEntry, "Password secure giriş ok")
        
    }
    
    func testisPasswordText() throws {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        ekran = storyboard.instantiateViewController(withIdentifier: "main") as? LoginViewController
        ekran.loadViewIfNeeded()
        let adtextbox = try XCTUnwrap(ekran.txtPassword, "Şifre Girişi")
        XCTAssertEqual(adtextbox.textContentType, .password, "Şifre girişi password tipinde")
    }
    
    func testisEmailText() throws {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        ekran = storyboard.instantiateViewController(withIdentifier: "main") as? LoginViewController
        ekran.loadViewIfNeeded()
        let adtextbox = try XCTUnwrap(ekran.txtEmail, "Mail Girişi")
        XCTAssertEqual(adtextbox.textContentType, .emailAddress, "Email girişi emailadress tipinde")
    }
    
    
    
}
