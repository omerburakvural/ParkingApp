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
import MaterialComponents

class UserDetailViewController: UIViewController {
    var db: Firestore!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameEditbtn: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var passwordEditButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var viewModel = UserDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
    
}


