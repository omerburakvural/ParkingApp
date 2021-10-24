//
//  NewUserViewController.swift
//  ParkingApp
//
//  Created by Adem Er on 13.10.2021.
//test
//

import UIKit
import Firebase
import FirebaseAuth

class NewUserViewController: UIViewController {

    
    var newuserviewmodel = NewUserViewModel()
    
    @IBOutlet weak var navi: UINavigationItem!
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var soyadLabel: UILabel!
    @IBOutlet weak var epostaLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwrdagainLabel: UILabel!
    
    @IBOutlet weak var solustbuton: UIBarButtonItem!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var kayitButon: UIButton!
    
    @IBOutlet weak var adTextbox: UITextField!
    @IBOutlet weak var soyadTextbox: UITextField!
    @IBOutlet weak var epostaTextbox: UITextField!
    @IBOutlet weak var passwordTextbox: UITextField!
    @IBOutlet weak var passwordagainTextbox: UITextField!
    
    @IBOutlet weak var hideButton: UIButton!
    
   
    
    @IBAction func hideButton(_ sender: Any) {
        passwordTextbox.isSecureTextEntry.toggle()
        passwordagainTextbox.isSecureTextEntry.toggle()
           if passwordTextbox.isSecureTextEntry && passwordagainTextbox.isSecureTextEntry {
               let image = UIImage(systemName: "eye")
//                   (sender as AnyObject).setImage(image, for: .normal)
                   
                   hideButton.setImage(image, for: .normal)
                   
               }
            else {
//               if let image = UIImage(systemName: "eye.slash.fill") {
//                   (sender as AnyObject).setImage(image, for: .normal)
                let image = UIImage(systemName: "eye.slash.fill")
 //                   (sender as AnyObject).setImage(image, for: .normal)
                   
                    hideButton.setImage(image, for: .normal)
               }
           }
        
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func valideteFields()
    {
        
        if adTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || soyadTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            epostaTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordagainTextbox.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            errorLabel.text = "Lütfen bilgilerinizi giriniz"
//            bilgiler validasyon edildi
    }
        else
        {
        errorLabel.text = ""
        }
        
        if passwordTextbox.text == passwordagainTextbox.text
        {
            return
        }
        else
        {
            errorLabel.text = "Şifreleriniz aynı olmalıdır"
        }
        
        
       
        
    }
    @IBAction func kayitButon(_ sender: Any) {
        
    valideteFields()

        let name = self.adTextbox.text
        let surname = self.soyadTextbox.text
        let email = self.epostaTextbox.text
        let password = self.passwordTextbox.text
        
        newuserviewmodel.email = email
        newuserviewmodel.password = password
        newuserviewmodel.name = name
        newuserviewmodel.usersurname = surname
      

        
        Auth.auth().createUser(withEmail: newuserviewmodel.email!, password: newuserviewmodel.password!) { (user, error) in

     //            self.errorLabel.text = email
                 if let error = error as NSError? {
                 switch AuthErrorCode(rawValue: error.code) {
                 case .operationNotAllowed: break
                   // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                 case .emailAlreadyInUse: break
                   // Error: The email address is already in use by another account.
                 case .invalidEmail: break
                   // Error: The email address is badly formatted.
                 case .weakPassword: break
                   // Error: The password must be 6 characters long or more.
                 default:
                     print("Error: \(error.localizedDescription)")
                 }
               }

               else {
                 print("Kayıt başarılı")
     //            let newUserInfo = Auth.auth().currentUser
     //            let email = newUserInfo?.email
               }
             }
             
         }
    
  

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        passwordTextbox.isSecureTextEntry.toggle()
        passwordagainTextbox.isSecureTextEntry.toggle()
//        errorLabel.text = newuserviewmodel.username
      
        
    }
    
    
}





