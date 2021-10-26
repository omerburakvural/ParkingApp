//
//  UserViewController.swift
//  MathQuiz
//
//  Created by Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu] on 23.10.2021.
//  Copyright © 2021 Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu]. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore


class UserViewController: UIViewController {
    var db: Firestore!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = UserDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let settings = FirestoreSettings()

               Firestore.firestore().settings = settings
               // [END setup]
               db = Firestore.firestore()
        
        tableView.dataSource = self
        //tableView.delegate = self
        self.tableView.separatorStyle = .none
        
        if let name = viewModel.user?.userName{
            self.nameTextField.text = name
        } else {
//            loading bekle
            let uid = (Auth.auth().currentUser?.uid)!
            
            let docRef = db.collection("users").document(uid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print(dataDescription)
                   let name = document["Name Surname"] as? String
//                    let surname = document["Surname"] as? String
                 
                     let isimsoyisim = "\(name!)"
                    self.nameTextField.text = String(isimsoyisim)
                    
                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
            
            
            
            
            
            
            self.nameTextField.text = "Ahmet Furkan Aytekin" }
        
        self.nameTextField.isEnabled = false
        
    }

    @IBAction func pressEditBtn(_ sender: Any) {
        self.nameTextField.isSelected = true
        self.nameTextField.isEnabled = true
        self.nameTextField.becomeFirstResponder()
        
    }
    
    @IBAction func kaydetButtonClicked(_ sender: Any) {
        _ = viewModel.saveUserName(withName: self.nameTextField.text)
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserDetailCell {
            //cell.delegate = self
            let data = viewModel.list[indexPath.row]
            let cellData = UserCellViewModel(user: UserCellDetail(key: data.title, value: data.value))
            cell.viewModel = cellData
            return cell
        }
        
        return UITableViewCell()
    }
}


