//
//  ForgotPasswordViewController.swift
//  ParkingApp
//
//  Created by PCMACEGITIM on 24.10.2021.
// Created by Seyma.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var yenileButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var NavBar: UINavigationBar!
    @IBOutlet weak var emailAdresi: UILabel!
    
    @IBOutlet weak var keyboardViewi: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // passwordView
        passwordView.layer.cornerRadius = 10.0
        passwordView.layer.shadowOpacity = 0.5
        passwordView.layer.shadowRadius = 10
        passwordView.layer.shadowOffset = CGSize (width: 10, height: 10)
        // yenileButton
        yenileButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailAddressTextField.text!){(error) in
            
            if let error = error{
                let alert = UIAlertController(title:"Uyarı",message:error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let alert = UIAlertController(title: "Bilgi", message: "Şifre resetlemek için mail adresinize mail yollanmıştır.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
    
}
