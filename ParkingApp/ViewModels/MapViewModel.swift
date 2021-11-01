//
//  MainMapViewModel.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import Foundation
import MapKit

class MapViewModel {
    var db = Firestore.firestore()
    var parkModelPins = [ParkModel]()
    var collectionName = "Parks"
    
    init(){
        db.collection(collectionName)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let capacity = document.data()["capacity"] as? Int
                        let has_vale = document.data()["has_vale"] as? Bool
                        let long = document.data()["long"] as? Double
                        let lat = document.data()["lat"] as? Double
                        let lpg_availability = document.data()["lpg_availability"] as? Bool
                        let park_name = document.data()["park_name"] as? String
                        let park_type = document.data()["park_type"] as? String
                        let payment_type = document.data()["payment_type"] as? String
                        let price = document.data()["price"] as? Int
                        let id = document.documentID
                        let pin = ParkModel.init(id:id,capacity:capacity!, has_vale:has_vale!, long:long!, lat:lat!, lpg_availability:lpg_availability!, park_name:park_name!, park_type:park_type!, payment_type:payment_type!, price:price!)
                        self.parkModelPins.append(pin)
                    }
                }
            }
    }
    
    func loadPinArray() -> [MKPointAnnotation] {
        var pinArray: [MKPointAnnotation] = []
        let count = parkModelPins.count
        for i in 0..<count {
            let pin = CustomPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: parkModelPins[i].lat, longitude: parkModelPins[i].long)
            pin.title = parkModelPins[i].park_name
            pin.tag = i
            pinArray.append(pin)
        }
        
        return pinArray
    }
}

class CustomPointAnnotation: MKPointAnnotation {
    var tag: Int!
}
