//
//  NewUserViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit

class NewUserViewController: UIViewController {

    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var soyadLabel: UILabel!
    @IBOutlet weak var epostaLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwrdagainLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var kayitButon: UIButton!
    
    @IBOutlet weak var adTextbox: UITextField!
    @IBOutlet weak var soyadTextbox: UITextField!
    @IBOutlet weak var epostaTextbox: UITextField!
    @IBOutlet weak var passwordTextbox: UITextField!
    @IBOutlet weak var passwordagainTextbox: UITextField!
    
    func valideteFields() -> String?
    {
        
        if adLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || soyadTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            epostaTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordagainTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
        return "please fill"
    }
     
        
        
return nil
        
    }
    @IBAction func kayitButon(_ sender: Any) {
        
      let email = "example@gmail.com"
//        test
//        let password = "testtest"
////        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//
//            if let error = error as NSError? {
//            switch AuthErrorCode(rawValue: error.code) {
//            case .operationNotAllowed: break
//              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
//            case .emailAlreadyInUse: break
//              // Error: The email address is already in use by another account.
//            case .invalidEmail: break
//              // Error: The email address is badly formatted.
//            case .weakPassword: break
//              // Error: The password must be 6 characters long or more.
//            default:
//                print("Error: \(error.localizedDescription)")
//            }
//          }
//
//          else {
//            print("User signs up successfully")
////            let newUserInfo = Auth.auth().currentUser
////            let email = newUserInfo?.email
//          }
//        }
        
    }
  

    func showError(_ message:String)
    {
//        errorLabel.text = message
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    
}





