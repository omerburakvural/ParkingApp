//
//  MapViewModelTest.swift
//  ParkingAppTest
//
//  Created by Omer Burak Vural on 2.11.2021.
//

import XCTest
@testable import ParkingApp
import MapKit

class MapViewModelTest: XCTestCase {
    let vm = MapViewModel()
    
    func testMapViewModelInit() throws{
        
        XCTAssertNoThrow(MapViewModel.init())
        XCTAssertNotNil(vm.parkModelPins)
    }
    
    func testLoadPinArray() throws {
        XCTAssertNotNil(vm.loadPinArray())
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
