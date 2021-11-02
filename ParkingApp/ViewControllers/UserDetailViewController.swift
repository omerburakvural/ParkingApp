//
//  UserViewController.swift
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import MaterialComponents

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameEditbtn: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var passwordEditButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var plakaTxtField: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var emailBtnClicked: UIButton!
    @IBOutlet weak var plateBtnClicked: UIButton!
    @IBOutlet weak var signoutButton: UIButton!
    
    var viewModel = UserDetailViewModel()
    let userEmail = (Auth.auth().currentUser?.email)
    var user = UserModel.init(name: "", email: "", plate: "", id: "")
    var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTxtField.text = ""
        self.plakaTxtField.text = ""
        self.plakaTxtField.placeholder = "Plakanızı girebilirsiniz"
        self.nameTextField.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
            self.loadUser()
        }
        self.nameTextField.isEnabled = false
        self.emailTxtField.isEnabled = false
        self.plakaTxtField.isEnabled = false
        self.nameTextField.backgroundColor = UIColor(named:"#07567A")
        self.emailTxtField.backgroundColor = UIColor(named:"#07567A")
        self.plakaTxtField.backgroundColor = UIColor(named:"#07567A")
    }
    
    @IBAction func kaydetButtonClicked(_ sender: Any) {
        user.userName = self.nameTextField.text ?? ""
        user.userEmail = self.emailTxtField.text ?? ""
        user.userPlate = self.plakaTxtField.text ?? ""
        user.userID = self.userID
        
        viewModel.updateUser(withUser: user)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nameEditBtnClicked(_ sender: UIButton) {
        self.nameTextField.isSelected = true
        self.nameTextField.isEnabled = true
        self.nameTextField.becomeFirstResponder()
        self.user.userName = self.nameTextField.text!
        
        if (self.nameTextField.backgroundColor == .separator) {
            self.nameTextField.backgroundColor = UIColor(named:"#07567A")
        }
        if (self.nameTextField.backgroundColor == UIColor(named:"#07567A")) {
            self.nameTextField.backgroundColor = .separator
        }
    }
    
    @IBAction func emailBtnClicked(_ sender: Any) {
        self.emailTxtField.isSelected = true
        self.emailTxtField.isEnabled = true
        self.emailTxtField.becomeFirstResponder()
        self.emailTxtField.background?.withTintColor(.opaqueSeparator)
        self.user.userEmail = self.emailTxtField.text!
        
        if (self.emailTxtField.backgroundColor == .separator) {
            self.emailTxtField.backgroundColor = UIColor(named:"#07567A")
        }
        if (self.emailTxtField.backgroundColor == UIColor(named:"#07567A")) {
            self.emailTxtField.backgroundColor = .separator
        }
    }
    
    @IBAction func plateBtnClicked(_ sender: Any) {
        self.plakaTxtField.isSelected = true
        self.plakaTxtField.isEnabled = true
        self.plakaTxtField.becomeFirstResponder()
        self.plakaTxtField.background?.withTintColor(.opaqueSeparator)
        self.user.userPlate = self.plakaTxtField.text!
        
        if (self.plakaTxtField.backgroundColor == .separator) {
            self.plakaTxtField.backgroundColor = UIColor(named:"#07567A")
        }
        if (self.plakaTxtField.backgroundColor == UIColor(named:"#07567A")) {
            self.plakaTxtField.backgroundColor = .separator
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signoutButton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let alert = UIAlertController(title: "Başarılı", message: "Oturumunuz başarıyla kapatıldı", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            //            KULLANICININ OTORUMU KAPATIP, ALERT VERDİK
            let storyboardLogin = UIStoryboard(name: "Main", bundle: nil)
            let signInPage = storyboardLogin.instantiateViewController(withIdentifier: "main") as! LoginViewController
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = signInPage
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
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
            if (self.userEmail == viewModel.users[i].userEmail){
                self.emailTxtField.text = viewModel.users[i].userEmail
                self.plakaTxtField.text = viewModel.users[i].userPlate
                self.nameTextField.text = viewModel.users[i].userName
                self.userID = viewModel.users[i].userID
            }
        }
    }
}


