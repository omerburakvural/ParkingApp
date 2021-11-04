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
    
}
