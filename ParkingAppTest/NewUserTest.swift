//
//  NewUserTest.swift
//  ParkingAppTest
//
//  Created by PCMACEGITIM on 30.10.2021.
//


import XCTest
import FirebaseAuth

@testable import ParkingApp

class NewUserTest: XCTestCase {
  
    var model = NewUserViewModel()
   
   
    var sut: NewUserViewController!
    func testisplaceholdertrueofname() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController
        sut.loadViewIfNeeded()
        
    }
    
    func testisSecureEnrty() throws{
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController
        sut.loadViewIfNeeded()
        let passwordtext = try XCTUnwrap(sut.passwordTextbox, "Password textbox")
        XCTAssertTrue(passwordtext.isSecureTextEntry, "Password secure giriş ok")
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    
    
    func testadTextField_WhenCreated_HasNameContentTypeSet() throws {
        //        let emailTextField = try XCTUnwrap(sut.adTextbox, "Email address UITextField is not connected")
       
        
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController
        sut.loadViewIfNeeded()
        let adtextbox = try XCTUnwrap(sut.adTextbox, "Ad Girişi")
        XCTAssertEqual(adtextbox.textContentType, .name, "Ad Girişi name tipinde")
    }
    
    
    func testNewUserModel() throws
    {
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController
        sut.loadViewIfNeeded()
        
        sut.adTextbox!.text! = "Park"
        sut.soyadTextbox!.text! = "Testuyg"
        sut.epostaTextbox!.text! = "parkapp@gmail.com"
        sut.passwordTextbox!.text! = "123456"
        sut.passwordagainTextbox!.text! = "123456"
        let plaka = "34NNN34"
        
        let name = sut.adTextbox.text
        let surname = sut.soyadTextbox.text
        let email = sut.epostaTextbox.text
        let password = sut.passwordTextbox.text
        
        
        model.email = email!
        model.password = password!
        model.name = name!
        model.usersurname = surname!
        model.plaka = plaka
        
        XCTAssertTrue(sut.adTextbox!.text != nil)
        XCTAssertTrue(sut.soyadTextbox!.text != nil)
        XCTAssertTrue(sut.epostaTextbox!.text != nil)
        XCTAssertTrue(sut.passwordTextbox!.text != nil)
        XCTAssertTrue(sut.passwordagainTextbox!.text != nil)
    
        
    }
    
    func testvalidateerisim() throws{
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController
        sut.loadViewIfNeeded()
        
        sut.adTextbox!.text! = "Park"
        sut.soyadTextbox!.text! = "Testuyg"
        sut.epostaTextbox!.text! = "parkapp@gmail.com"
        sut.passwordTextbox!.text! = "123456"
        sut.passwordagainTextbox!.text! = "123456"
        
//        sut.valideteFields()
//        let funcCheck = sut.valideteFields()
//        XCTAssertEqual(funcCheck, "problem bulunmuyor")
        
      let kontrolvalidate =  model.validateFields(user: sut.adTextbox!.text!, withSurname: sut.soyadTextbox!.text!, withEmail: sut.epostaTextbox!.text!, withPassword: sut.passwordTextbox!.text!, withPasswordagain: sut.passwordagainTextbox!.text!)
        XCTAssertEqual(kontrolvalidate, "problem bulunmuyor")
        XCTAssertNotNil(sut.adTextbox!.text!)
        XCTAssertNotNil(sut.soyadTextbox!.text!)
        XCTAssertNotNil(sut.epostaTextbox!.text!)
        XCTAssertNotNil(sut.passwordTextbox!.text!)
        XCTAssertNotNil(sut.passwordagainTextbox!.text!)
        
        
    }
    
    func testAlert() throws
    {
        let weakerror: AuthErrorCode = .weakPassword
        
        let kontrol = model.alertUser(of: weakerror)
        
        XCTAssertEqual(kontrol, "Zayıf şifre. Lütfen 6 karakterden fazla şifre giriniz")
        
        
        let appVerificationUserInteractionFailure: AuthErrorCode = .appVerificationUserInteractionFailure
        
        let appverify = model.alertUser(of: appVerificationUserInteractionFailure)
        
        XCTAssertEqual(appverify, "Uygulamada teknik problem mevcut")
        
        
        
        let emailAlreadyInUse: AuthErrorCode = .emailAlreadyInUse
        
        let emailverify = model.alertUser(of: emailAlreadyInUse)
        
        XCTAssertEqual(emailverify, "Lütfen başka e-posta adresi ile kaydolunuz")
        
        
        let internalError: AuthErrorCode = .internalError
        
        let internalErrorverify = model.alertUser(of: internalError)
        
        XCTAssertEqual(internalErrorverify, "Uygulamada teknik problem mevcut")
        
    
        let invalidEmail: AuthErrorCode = .invalidEmail
        
        let invalidEmailverify = model.alertUser(of: invalidEmail)
        
        XCTAssertEqual(invalidEmailverify, "Geçersiz e-mail adresi")
        
        
        let networkError: AuthErrorCode = .networkError
        
        let networkErrorverify = model.alertUser(of: networkError)
        
        XCTAssertEqual(networkErrorverify, "Lütfen internet bağlantınızı kontrol ediniz")
        
        
        
        
    }
    

    
    
    
}
    

