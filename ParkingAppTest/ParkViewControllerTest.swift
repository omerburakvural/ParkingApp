//
//  ParkViewControllerTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 2.11.2021.
//

import XCTest
@testable import ParkingApp

class ParkViewControllerTest: XCTestCase {

    var vc: ParkViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "MapDetail", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "mapDetail") as? ParkViewController)
        vc.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        vc = nil
    }

    func testRotaCizButton () throws{
        let storyboard = UIStoryboard(name: "MapDetail", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "mapDetail") as? ParkViewController)
        vc.loadViewIfNeeded()
        vc.rotaCizButon.sendActions(for: .touchUpInside)
        XCTAssertTrue(((vc.rotaCizButon.actions(forTarget: vc, forControlEvent: .touchUpInside)?.contains("rotaCizButtonClicked:")) != nil))
    }
    
    func checkPinInit() throws {
        XCTAssertNotNil(vc.pin)
    }


}
