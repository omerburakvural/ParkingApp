//
//  UserDetailViewModel.swift
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore




class UserDetailViewModel {
    var db = Firestore.firestore()
    var users = [UserModel]()
    
    init() {
        db.collection("Users")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let name = document.data()["Name Surname"] as? String
                        let email = document.data()["Email"] as? String
                        let plate = document.data()["Plaka"] as? String
                        let id = document.documentID
                        let user = UserModel.init(name: name!, email: email!, plate: plate ?? "", id: id)
                        self.users.append(user)
                    }
                }
            }
    }
}

public class UserModel: Codable {
    var userName: String
    var userEmail: String
    var userPlate: String
    var userID: String
    
    init(name: String, email: String, plate: String, id: String){
        self.userName = name
        self.userEmail = email
        self.userPlate = plate
        self.userID = id
    }
}
