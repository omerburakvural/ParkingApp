//
//  PasswordResetViewControllerTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 2.11.2021.
//

import XCTest
import FirebaseAuth
import Firebase

@testable import ParkingApp

class PasswordResetViewControllerTest: XCTestCase {
    
  
    
    var passwordmodel = PasswordChangeModel()
    
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
   
        let internalError: AuthErrorCode = .internalError
        let checkMessage = passwordmodel.alertUser(of: internalError)
        XCTAssertEqual(checkMessage, "Uygulamada teknik problem mevcut")
        
        let keychainError: AuthErrorCode = .keychainError
        let checkMessagekey = passwordmodel.alertUser(of: keychainError)
        XCTAssertEqual(checkMessagekey, "Keychain Hatası")
        
        let networkError: AuthErrorCode = .networkError
        let checkMessagenetwork = passwordmodel.alertUser(of: networkError)
        XCTAssertEqual(checkMessagenetwork, "Lütfen internet bağlantınızı kontrol ediniz")
        
        let weakPassword: AuthErrorCode = .weakPassword
        let checkMessageweak = passwordmodel.alertUser(of: weakPassword)
        XCTAssertEqual(checkMessageweak, "Zayıf şifre. Lütfen 6 karakterden fazla şifre giriniz")
        
        let wrongPassword: AuthErrorCode = .wrongPassword
        let checkMessagewrong = passwordmodel.alertUser(of: wrongPassword)
        XCTAssertEqual(checkMessagewrong, "Başka şifre seçiniz")
        
    }
    func testValidasyon() throws
    {
        
        let yenisifre = "234567"
        let sifre = "123456"
        let yenisifretekrar = "234567"
        
        let kontrolValidasyonReturn = passwordmodel.validasyon(sifre: sifre, yenisifre: yenisifre, yenisifretekrar: yenisifretekrar)
        XCTAssertEqual(kontrolValidasyonReturn, true)
        XCTAssertTrue(kontrolValidasyonReturn)
     
    }
    
    func testValidasyonFalseRetur() throws
    {
        let sifre = "123456"
        let yenisifres = "123456"
        let yenisifrestekrar = "123456"
        let kontrolValidasyonHataDondur = passwordmodel.validasyon(sifre: sifre, yenisifre: yenisifres, yenisifretekrar: yenisifrestekrar)
        XCTAssertFalse(kontrolValidasyonHataDondur)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
