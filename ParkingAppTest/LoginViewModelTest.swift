//
//  LoginViewModelTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 1.11.2021.
//

import XCTest
@testable import ParkingApp

class LoginViewModelTest: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

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
    
    
//    func testTaskTitle () {
//        let task = Task(context: viewContext)
//        task.title = "Emre"
//        let vm = TaskCellViewModel(task: task)
//
//        XCTAssertEqual(vm.title, "Emre")
//
//        task.title = nil
//        XCTAssertEqual(vm.title, "")
//    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
