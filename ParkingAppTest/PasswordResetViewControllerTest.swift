//
//  PasswordResetViewControllerTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 2.11.2021.
//

import XCTest
import FirebaseAuth
@testable import ParkingApp

class PasswordResetViewControllerTest: XCTestCase {
    var vc: PasswordResetViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController)
        vc.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        vc = nil
    }
    
    func testKaydetButtonClicked() throws {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController)
        vc.loadViewIfNeeded()
        
        vc.mevcutSifre.text = "123456"
        vc.yeniSifre.text = "123123123"
        vc.yeniSifreTekrar.text = "123123123"
        vc.usermodeli.email = "omerburakvural@gmail.com"
        
        vc.kaydetButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(((vc.kaydetButton.actions(forTarget: vc, forControlEvent: .touchUpInside)?.contains("kaydetButtonClicked:")) != nil))
    }

    
    func testAlertUser() throws{
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController)
        vc.loadViewIfNeeded()
        
        var checkMessage: String = ""
        
        let internalError: AuthErrorCode = .internalError
        checkMessage = vc.alertUser(of: internalError)
        XCTAssertEqual(checkMessage, "Uygulamada teknik problem mevcut")
        
        let keychainError: AuthErrorCode = .keychainError
        checkMessage = vc.alertUser(of: keychainError)
        XCTAssertEqual(checkMessage, "Keychain Hatası")
        
        let networkError: AuthErrorCode = .networkError
        checkMessage = vc.alertUser(of: networkError)
        XCTAssertEqual(checkMessage, "Lütfen internet bağlantınızı kontrol ediniz")
        
        let weakPassword: AuthErrorCode = .weakPassword
        checkMessage = vc.alertUser(of: weakPassword)
        XCTAssertEqual(checkMessage, "Zayıf şifre. Lütfen 6 karakterden fazla şifre giriniz")
        
        let wrongPassword: AuthErrorCode = .wrongPassword
        checkMessage = vc.alertUser(of: wrongPassword)
        XCTAssertEqual(checkMessage, "Mevcut şifreyi doğru giriniz")
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
