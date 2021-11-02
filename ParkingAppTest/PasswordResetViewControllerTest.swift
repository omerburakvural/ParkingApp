//
//  PasswordResetViewControllerTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 2.11.2021.
//

import XCTest
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

    func kaydetButtonTest() throws {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController)
        vc.loadViewIfNeeded()
        
        vc.kaydetButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(((vc.kaydetButton.actions(forTarget: vc, forControlEvent: .touchUpInside)?.contains("kaydetButtonClicked:")) != nil))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
