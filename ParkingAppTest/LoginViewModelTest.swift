//
//  LoginViewModelTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 1.11.2021.
//

import XCTest
import Firebase
import FirebaseAuth

@testable import ParkingApp

class LoginViewModelTest: XCTestCase {
    
    var usw: LoginViewController!
    var forgot: ForgotPasswordViewController!
    var newuser: NewUserViewController!
    var mainmap: MapViewController!
    let loginModel = LoginViewModel()
    //    override func setUpWithError() throws {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDownWithError() throws {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    
    func testsayfaacilis() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        usw = storyboard.instantiateViewController(withIdentifier: "main") as? LoginViewController
        usw.loadViewIfNeeded()
        
    }
    
    func testLoginViewModel () {
        var testEmail = ""
        var testPassword = ""
        var testRememberSwitch = true
        let vm = LoginViewModel()
        
        XCTAssertFalse(vm.userAuthCheck(withEmail: testEmail, andWithPassword: testPassword, andWithSwitch: testRememberSwitch))
        testEmail = "omerburakvural@gmail.com"
        testPassword = "123456"
        testRememberSwitch = true
        XCTAssertTrue(vm.userAuthCheck(withEmail: testEmail, andWithPassword: testPassword, andWithSwitch: testRememberSwitch))
    }
    
    func testSecureEntry() throws {
        
        testsayfaacilis()
        usw.hideButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(usw.txtPassword.isSecureTextEntry, false)

    }
    
    func testSwitch() throws {
        testsayfaacilis()
        usw.switchRememberMe.isOn = true
        XCTAssertEqual(usw.switchRememberMe.isOn, true)
    }
    
    func testNoUser() throws {
        
        testsayfaacilis()
        usw.noUserButtonClicked.sendActions(for: .touchUpInside)
        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
        mainmap = storyboard.instantiateViewController(withIdentifier: "mainMap") as? MapViewController
        mainmap.loadViewIfNeeded()
        print(mainmap.editProfileButton.isEnabled)
//        XCTAssertEqual(mainmap.editProfileButton.isEnabled, false)
        
    }
    
    func testLoginEmailPlaceandType() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        testsayfaacilis()
        let emailtextbox = try XCTUnwrap(usw.txtEmail, "Email Girişi")
        let nameValue = "Email"
        XCTAssertEqual(emailtextbox.placeholder!, nameValue)
        XCTAssertEqual(emailtextbox.textContentType, .emailAddress)
    }
    
    func testLoginPassPlaceHolderandType() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        testsayfaacilis()
        let passwordtextbox = try XCTUnwrap(usw.txtPassword, "Password")
        let nameValue = "Password"
        XCTAssertEqual(passwordtextbox.placeholder!, nameValue)
        XCTAssertEqual(passwordtextbox.textContentType, .password)
        
    }
    
    func testForgotPass() throws {
//        Kullanıcı login olduktan sonra şifremi unuttum butonuna basıp, forgot password sayfasında butona basabiliyor mu
        testsayfaacilis()
        usw.forgotPasswordClicked.sendActions(for: .touchUpInside)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        forgot = storyboard.instantiateViewController(withIdentifier: "passwordMain") as? ForgotPasswordViewController
        forgot.loadViewIfNeeded()
        forgot.emailAddressTextField!.text! = "parkingapp@gmail.com"
        forgot.yenileButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(forgot.yenileButton.isEnabled, true)
    }
    func testNewUser() throws {
//        Kullanıcı login olduktan sonra şifremi unuttum butonuna basıp, forgot password sayfasında butona basabiliyor mu
        testsayfaacilis()
        usw.newUserButtonClicked.sendActions(for: .touchUpInside)
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        newuser = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController
        newuser.loadViewIfNeeded()

            newuser.adTextbox!.text! = "Park"
        newuser.soyadTextbox!.text! = "AppUyg"
        newuser.epostaTextbox!.text! = "parkingappsı@gmail.com"
        newuser.passwordTextbox!.text! = "123456"
        newuser.passwordagainTextbox!.text! = "123456"
        newuser.kayitButon.sendActions(for: .touchUpInside)
        XCTAssertEqual(newuser.kayitButon.isEnabled, true)
        
    }
    
    func testHideButon() throws {
        
        testsayfaacilis()
        usw.hideButton.sendActions(for: .touchUpInside)
       
    }
    func testUserAuth() throws{
        testsayfaacilis()
        let testEmail = "omerburakvural@gmail.com"
       let  testPassword = "123456"
         usw.userAuth(withEmail: testEmail, andWithPassword: testPassword)
        usw.girisButton.sendActions(for: .touchUpInside)
        var check = usw.isUserLoggedIn()
        XCTAssertEqual("\(check)", "işlem ok")

    }
    
    func testAlertUser() throws{
   
        let internalError: AuthErrorCode = .internalError
        let checkMessage = loginModel.alertUser(of: internalError)
        XCTAssertEqual(checkMessage, "Uygulamada teknik problem mevcut")
        
        let keychainError: AuthErrorCode = .keychainError
        let checkMessagekey = loginModel.alertUser(of: keychainError)
        XCTAssertEqual(checkMessagekey, "Keychain Hatası")
        
        let networkError: AuthErrorCode = .networkError
        let checkMessagenetwork = loginModel.alertUser(of: networkError)
        XCTAssertEqual(checkMessagenetwork, "Lütfen internet bağlantınızı kontrol ediniz")
        
        let weakPassword: AuthErrorCode = .weakPassword
        let checkMessageweak = loginModel.alertUser(of: weakPassword)
        XCTAssertEqual(checkMessageweak, "Zayıf şifre. Lütfen 6 karakterden fazla şifre giriniz")
        
        let wrongPassword: AuthErrorCode = .wrongPassword
        let checkMessagewrong = loginModel.alertUser(of: wrongPassword)
        XCTAssertEqual(checkMessagewrong, "Başka şifre seçiniz")
        
    }
    
}


