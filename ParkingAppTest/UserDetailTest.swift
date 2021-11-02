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

    var usermodelipbclass = UserModel(name: "Test User", email: "testmaili@gmail.com", plate: "34XXX34", id: "123")
    var sut: UserDetailViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testsignoutButton() throws {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "userDetail") as? UserDetailViewController)
        sut.loadViewIfNeeded()
        sut.signoutButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(((sut.signoutButton.actions(forTarget: sut, forControlEvent: .touchUpInside)?.contains("signoutButton:")) != nil))
        
    }
    func testnameTextField() throws {

        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "userDetail") as? UserDetailViewController
        sut.loadViewIfNeeded()
        let nameTextField = try XCTUnwrap(sut.nameTextField, "Ad")
        XCTAssertEqual(nameTextField.textContentType, .name, "Ad .name tipinde")
//        XCTAssertTrue(adtextbox.isEnabled) as! Bool
        sut.nameEditbtn.sendActions(for: .touchUpInside)
        print(sut.nameTextField.isEnabled)
        XCTAssertEqual(sut.nameTextField.isEnabled, true)
        
    
    }
    func testModelIsNull() throws {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "userDetail") as? UserDetailViewController)
        sut.loadViewIfNeeded()

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
