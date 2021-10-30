//
//  ParkModel.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore

class ParkModel: Codable {
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
