//
//  PasswordResetController.swift
//  ParkingApp
//
//  Created by PCMACEGITIM on 24.10.2021.
//

import UIKit
import Firebase

class PasswordResetController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
