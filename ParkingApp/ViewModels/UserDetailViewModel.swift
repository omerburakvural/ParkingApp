//
//  UserDetailViewModel.swift
//

import Foundation
import UIKit
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
    
    func updateUser(withUser: UserModel) {
        let updatedUserRef = db.collection("Users").document(withUser.userID)
        
        updatedUserRef.updateData(["Name Surname": withUser.userName]){ error in
            if let error = error {
                print("Error updating Name: \(error)")
            } else {
                print("Name successfully updated")
            }
        }
        updatedUserRef.updateData(["Email" : withUser.userEmail]){ error in
            if let error = error {
                print("Error updating Email: \(error)")
            } else {
                print("Email successfully updated")
            }
        }
        updatedUserRef.updateData(["Plaka" : withUser.userPlate]){ error in
            if let error = error {
                print("Error updating Plaka: \(error)")
            } else {
                print("Plaka successfully updated")
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
