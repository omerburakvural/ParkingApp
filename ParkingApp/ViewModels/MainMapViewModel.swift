//
//  MainMapViewModel.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import Foundation

class MainMapViewModel {
    var db = Firestore.firestore()
    var parkModelPins = [ParkModel]()
    
    init(){
        db.collection("Parks")
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
}

public class ParkModel: Codable {
    var capacity: Int
    var has_vale: Bool
    var lat: Double
    var long: Double
    var lpg_availability: Bool
    var park_name: String
    var park_type: String
    var payment_type: String
    var price: Int
    var documentID: String
    
    init(id: String,capacity: Int,has_vale:Bool,long:Double,lat:Double,lpg_availability:Bool,park_name:String,park_type:String,payment_type:String,price:Int){
        self.capacity = capacity
        self.has_vale = has_vale
        self.long = long
        self.lat = lat
        self.lpg_availability = lpg_availability
        self.park_name = park_name
        self.park_type = park_type
        self.payment_type = payment_type
        self.price = price
        self.documentID = id
    }
}



