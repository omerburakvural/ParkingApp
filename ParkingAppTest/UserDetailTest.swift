//
//  UserDetailTest.swift
//  ParkingAppTest
//
//  Created by PCMACEGITIM on 2.11.2021.
//

import XCTest
@testable import ParkingApp

class UserDetailTest: XCTestCase {

    var model = UserDetailViewModel()
    let vm = LoginViewModel()
    var passwordmodel = PasswordChangeModel()
    var usermodelipbclass = UserModel(name: "Test User", email: "testmaili@gmail.com", plate: "34XXX34", id: "123")
    var sut: UserDetailViewController!
    var tus: PasswordResetViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func sayfabaslatma()
    {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "userDetail") as? UserDetailViewController
        sut.loadViewIfNeeded()
    }
    
    func testBackButton()
    {
        sayfabaslatma()
        XCTAssertTrue(sut.backButton.isEnabled)
        
    }
    
    func testKaydetButton()
    {
        sayfabaslatma()
        XCTAssertTrue(sut.saveButton.isEnabled)
        sut.saveButton.action
        XCTAssertNotNil(usermodelipbclass.userID)
        XCTAssertNotNil(usermodelipbclass.userEmail)
        XCTAssertNotNil(usermodelipbclass.userName)
        XCTAssertNotNil(usermodelipbclass.userPlate)
        XCTAssertNotNil(UserModel.init(name:email:plate:id:))
        
    }
    
 
    func testsignoutButton() throws {
        sayfabaslatma()
        sut.signoutButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(((sut.signoutButton.actions(forTarget: sut, forControlEvent: .touchUpInside)?.contains("signoutButton:")) != nil))
        
    }
    func testnameTextField() throws {

        sayfabaslatma()
        let nameTextField = try XCTUnwrap(sut.nameTextField, "Ad")
        XCTAssertEqual(nameTextField.textContentType, .name, "Ad .name tipinde")
        sut.nameEditbtn.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.nameTextField.isEnabled, true)
    }
    func testPlateEnabled() throws {

        sayfabaslatma()
        let plakaTextField = try XCTUnwrap(sut.plakaTxtField, "Plaka")
        XCTAssertEqual(plakaTextField.textContentType, .sublocality, "Plaka sublocality tipinde")
        sut.plateBtnClicked.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.plakaTxtField.isEnabled, true)
    }
    func testEmailEnabled() throws {

        sayfabaslatma()
        let plakaTextField = try XCTUnwrap(sut.emailTxtField, "Email")
        XCTAssertEqual(plakaTextField.textContentType, .emailAddress, "Email, email adress tipinde")
        sut.emailBtnClicked.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.emailTxtField.isEnabled, true)
    }
    func testPasswordEkran() throws {

        sayfabaslatma()
        sut.passwordEditButton.sendActions(for: .touchUpInside)
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        tus = storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController
        tus.loadViewIfNeeded()
        let kontrol = tus.yeniSifre.isEnabled
        XCTAssertEqual(kontrol, true)
        let butonkontrol = tus.kaydetButton.isHidden
        let butonacikmi = tus.kaydetButton.isEnabled
        XCTAssertEqual(butonacikmi, true)
        XCTAssertFalse(butonkontrol)
        
   
    }
    
    func testLoginGirisi() throws
    {
        var testEmail = ""
        var testPassword = ""
        var testRememberSwitch = true
       
//        sut.signoutButton.sendActions(for: .touchUpInside)
       
        let vm = LoginViewModel()
        
        XCTAssertFalse(vm.userAuthCheck(withEmail: testEmail, andWithPassword: testPassword, andWithSwitch: testRememberSwitch))
        testEmail = "omerburakvural@gmail.com"
        testPassword = "123456"
        testRememberSwitch = true
        XCTAssertTrue(vm.userAuthCheck(withEmail: testEmail, andWithPassword: testPassword, andWithSwitch: testRememberSwitch))
        sayfabaslatma()
        sut.signoutButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.signoutButton.isEnabled, true)
        XCTAssertEqual(sut.signoutButton.isHidden, false)
    
        
    }
    
    func testSifreDegistirMevcutHide() throws
    {
        sayfabaslatma()
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        tus = storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController
        tus.loadViewIfNeeded()
        tus.hidemevcutsifre.sendActions(for: .touchUpInside)
        XCTAssertFalse(tus.mevcutSifre.isSecureTextEntry)
    }
    func testSifreDegistirYeniHide() throws
    {
        sayfabaslatma()
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        tus = storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController
        tus.loadViewIfNeeded()
        tus.hideYeniSifre.sendActions(for: .touchUpInside)
        XCTAssertFalse(tus.yeniSifre.isSecureTextEntry)
        tus.yeniSifre!.text! = "234567"
        tus.yeniSifre.sendActions(for: .editingChanged)
        print(tus.yeniSifreTekrar!.text!)
        XCTAssertEqual(tus.yeniSifreTekrar!.text!, "234567")
        XCTAssertNotNil(tus.yeniSifreTekrar!.text!)
    }
    
    func testTextbox() throws
    {
        sayfabaslatma()
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        tus = storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController
        tus.loadViewIfNeeded()
        tus.hideYeniSifre.sendActions(for: .touchUpInside)
        XCTAssertFalse(tus.yeniSifre.isSecureTextEntry)
        
    }
    
    
    func testModelIsNull() throws {
        sayfabaslatma()

        XCTAssertNotNil(usermodelipbclass.userName)
        XCTAssertNotNil(usermodelipbclass.userEmail)
        XCTAssertNotNil(usermodelipbclass.userPlate)
        XCTAssertNotNil(usermodelipbclass.userID)
        
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
