//
//  MainMapViewModel.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit
import FirebaseDatabase
import Firebase

struct Pin{
    var lat: Double
    var long: Double
    var name: String
}

class MainMapViewModel {
    
    let ref = Database.database().reference(withPath: "Park")
    var name = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    var numberOfParks = 0
    
    func loadPin(withIndex: Int) {
        let index = String(withIndex)
        let childRef = ref.child(index)
        
        childRef.child("lat").observeSingleEvent(of: .value, with: {(snapshot) in
            self.setLat(withCoordinate: snapshot.value as! Double)
        })
        childRef.child("long").observeSingleEvent(of: .value, with: {(snapshot) in
            self.setLong(withCoordinate: snapshot.value as! Double)
        })
        childRef.child("park_name").observeSingleEvent(of: .value, with: {(snapshot) in
            self.setName(withName: snapshot.value as! String)
        })
        ref.observe(.value, with: { snapshot in
            self.setNumberOfParks(withNumber: Int(snapshot.childrenCount))
        })
    }
    
    func setLat(withCoordinate: Double){
        lat = withCoordinate
    }
    
    func setLong(withCoordinate: Double){
        long = withCoordinate
    }
    func setName(withName: String){
        name = withName
    }
    
    func setNumberOfParks(withNumber: Int){
        numberOfParks = withNumber
    }
    
    
    func getName() -> String {
        return name
    }
    
    func getLat() -> Double {
        return lat
    }
    
    func getLong() -> Double {
        return long
    }
    
    func getNumberOfParks() -> Int {
        return numberOfParks
    }
}

//class ParkModel: Codable {
//    var capacity: Int = 0
//    var has_vale: String = ""
//    var lat: Double = 0.0
//    var long: Double = 0.0
//    var lpg_availability: String = ""
//    var park_name: String = ""
//    var park_type: String = ""
//    var payment_type: String = ""
//    var price: Int = 0
//}



