//
//  ForgotPasswordViewControllerTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 2.11.2021.
//

import XCTest
@testable import ParkingApp

class ForgotPasswordViewControllerTest: XCTestCase {

    var vc: ForgotPasswordViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "passwordMain") as? ForgotPasswordViewController)
        vc.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        vc = nil
    }

    func testBackButton() throws{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "passwordMain") as? ForgotPasswordViewController)
        vc.loadViewIfNeeded()
        
        vc.backButton.target?.perform(vc.backButton.action, with: nil)
        XCTAssertTrue(((vc.backButton.action?.description.contains("backButton")) != nil))
    }
    
    func testSendButtonTapped() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "passwordMain") as? ForgotPasswordViewController)
        vc.loadViewIfNeeded()
        
        vc.yenileButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(((vc.yenileButton.actions(forTarget: vc, forControlEvent: .touchUpInside)?.contains("sendButtonTapped:")) != nil))
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
