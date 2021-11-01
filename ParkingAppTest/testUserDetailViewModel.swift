//
//  testUserDetailViewModel.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 1.11.2021.
//

import XCTest
import ParkingApp
@testable import ParkingApp

class UserDetailViewModelTest: XCTestCase {


    
    func testUpdateUser() throws {
        
        var user = UserModel.init(name: "", email: "", plate: "", id: "")
        var user2 = UserModel.init(name: "aaa", email: "aaa@aaa", plate: "34xx34", id: "asdasdasdrfe")
        let vm = UserDetailViewModel()
        
        XCTAssertEqual(user.userName, "")
        XCTAssertEqual(user.userEmail, "")
        XCTAssertEqual(user.userID, "")
        XCTAssertEqual(user.userPlate, "")
        
        XCTAssertNotEqual(user2.userName, "")
        XCTAssertNotEqual(user2.userEmail, "")
        XCTAssertNotEqual(user2.userID, "")
        XCTAssertNotEqual(user2.userPlate, "")
        
        XCTAssertFalse(vm.updateUser(withUser: user2))
        //XCTAssertThrowsError(<#T##expression: T##T#>)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
