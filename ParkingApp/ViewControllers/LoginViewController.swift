//
//  LoginViewController.swift
//  LoginWithFullPicture
//
//  Created by Zeynep Zincirli on 16.10.2021.
//

import UIKit
import Firebase

struct UserRemember{
    static let emailKey = "email"
    static let passwordKey = "password"
    static let rememberMeKey = "rememberMe"
}

class LoginViewController: UIViewController {

    @IBOutlet weak var switchRememberMe: UISwitch!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    //deneme
    @IBOutlet weak var girisButton: UIButton!
    @IBOutlet weak var cardView: UIView!

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cardView
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = CGSize (width: 10, height: 10)
        // girisButton
        girisButton.layer.cornerRadius = 10.0
        
        // Beni hatırla fonksiyonu
        let isRememberMe = defaults.bool(forKey: UserRemember.rememberMeKey)
        
        if isRememberMe
        {
            let email = defaults.string(forKey: UserRemember.emailKey)
            let password = defaults.string(forKey: UserRemember.passwordKey)
            txtEmail.self.insertText(email ?? "")
            txtPassword.self.insertText(password ?? "")
        }
        
    }
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        let email = txtEmail.self.text
        let password = txtPassword.self.text
        
        if (email?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            let alert = UIAlertController(title: "Uyarı", message: "Email ve şifre alanı boş bırakılamaz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Kapat", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else
        {
            if switchRememberMe.isOn
            {
                defaults.set(email, forKey: UserRemember.emailKey)
                defaults.set(password, forKey: UserRemember.passwordKey)
                defaults.set(true, forKey: UserRemember.rememberMeKey)
                
                Auth.auth().signIn(withEmail: email!, password: password!){
                    (result,error) in
                    if error != nil
                    {
                        let alert = UIAlertController(title: "Uyarı", message: "Girdiğiniz kullanıcı bilgileri hatalıdır. Lütfen kontrol ediniz.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Kapat", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: "mainMap") as? MainMapViewController {
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false, completion: nil)
                            }
                    }
                }
            }
        }
    }
    
    @IBAction func rememberMeSwitchChanged(_ sender: UISwitch)
    {
        if sender.isOn
        {
            defaults.set(true, forKey: UserRemember.rememberMeKey)
        }else{
            defaults.set(false, forKey: UserRemember.rememberMeKey)
        }
    }
    
    @IBAction func newUserButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    
    @IBAction func noUserButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "mainMap") as? MainMapViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "passwordMain") as? PasswordResetController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
}


