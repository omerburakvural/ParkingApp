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
    
    @IBOutlet weak var signoutButton: UIButton!
    
    var viewModel = UserDetailViewModel()
    let userEmail = (Auth.auth().currentUser?.email)
    var user = UserModel.init(name: "", email: "", plate: "", id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = (Auth.auth().currentUser?.uid)
       
        if (uid == nil)
        {
           
//                KULLANICININ GİRİŞ YAPMADIĞINI BÖYLE YAKALAYABİLİYORUZ. BURADA BİR ÇÖZÜM ÜRETİRSEK, KULLANICIYI İÇERİ ALMAYABİLİRİZ
//             REMOVE FROM PARENT DENEDİM AMA HİYERARŞİ HATASINA YÜRÜDÜ. BURADA BİR ÇÖZÜM BULABİLİR MİYİZ ?
        }
        
        self.emailTxtField.text = ""
        self.plakaTxtField.text = ""
        self.nameTextField.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
        self.loadUser()
        }
    }

    @IBAction func nameEditBtnClicked(_ sender: Any) {
        self.nameTextField.isSelected = true
        self.nameTextField.isEnabled = true
        self.nameTextField.becomeFirstResponder()
        
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
            }
        }
    }
}


