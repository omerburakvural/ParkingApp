//
//  UserViewController.swift
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import MaterialComponents

class UserDetailViewController: UIViewController {
    var db: Firestore!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameEditbtn: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var passwordEditButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var plakaTxtField: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    var viewModel = UserDetailViewModel()
    let userEmail = (Auth.auth().currentUser?.email)
    var user = UserModel.init(name: "", email: "", plate: "", id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) {
        self.loadUser()
        }
        self.nameTextField.text = user.userName
        self.emailTxtField.text = user.userEmail
        self.plakaTxtField.text = user.userPlate
    }

    @IBAction func nameEditBtnClicked(_ sender: Any) {
        self.nameTextField.isSelected = true
        self.nameTextField.isEnabled = true
        self.nameTextField.becomeFirstResponder()
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func passwordEditButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "passwordReset") as? PasswordResetViewController {
            let bottomSheet = MDCBottomSheetController(contentViewController: vc)
            self.present(bottomSheet, animated: true, completion: nil)
        }
    }
    
    func loadUser(){
        
        for i in 0..<viewModel.users.count {
            if (self.user.userEmail == viewModel.users[i].userEmail){
                print("hello")
                self.user.userEmail = viewModel.users[i].userEmail
                self.user.userPlate = viewModel.users[i].userPlate
                self.user.userName = viewModel.users[i].userName
                self.user.userID = viewModel.users[i].userID
                print(viewModel.users[i].userEmail)
            }
        }
    }
}


