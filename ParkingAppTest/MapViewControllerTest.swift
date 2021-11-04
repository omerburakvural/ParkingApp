//
//  MapViewControllerTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 2.11.2021.
//

import XCTest
@testable import ParkingApp

class MapViewControllerTest: XCTestCase {

    var vc: MapViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "mainMap") as? MapViewController)
        vc.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        vc = nil
    }
    
    func testArrowButton() throws{
        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "mainMap") as? MapViewController)
        vc.loadViewIfNeeded()
        
        vc.arrowButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(((vc.arrowButton.actions(forTarget: vc, forControlEvent: .touchUpInside)?.contains("arrowButtonClicked:")) != nil))
    }
    
    func testProfileButton() throws{
        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "mainMap") as? MapViewController)
        vc.loadViewIfNeeded()
        
        vc.editProfileButton.target?.perform(vc.editProfileButton.action, with: nil)
        XCTAssertTrue(((vc.editProfileButton.action?.description.contains("editProfileButtonClicked")) != nil))
    }
    
    func testBackButton() throws{
        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
        vc = (storyboard.instantiateViewController(withIdentifier: "mainMap") as? MapViewController)
        vc.loadViewIfNeeded()
        
        vc.backButton.target?.perform(vc.backButton.action, with: nil)
        XCTAssertTrue(((vc.backButton.action?.description.contains("backButtonClicked")) != nil))
    }
}
