//
//  PasswordEditViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 29.10.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PasswordResetViewController: UIViewController{
    
    @IBOutlet weak var mevcutSifre: UITextField!
    @IBOutlet weak var yeniSifre: UITextField!
    @IBOutlet weak var yeniSifreTekrar: UITextField!
    
    @IBOutlet weak var kaydetButton: UIButton!
    
    @IBOutlet weak var yeniSifreTekrarLabel: UILabel!
    @IBOutlet weak var hidemevcutsifre: UIButton!
    @IBOutlet weak var hideYeniSifre: UIButton!
    
    var passwordmodel = PasswordChangeModel()
    var usermodeli = NewUserViewModel()
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        mevcutSifre.isSecureTextEntry.toggle()
        yeniSifre.isSecureTextEntry.toggle()
        yeniSifreTekrar.isSecureTextEntry.toggle()
        view.layer.cornerRadius = 15.0
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        if let uid = (Auth.auth().currentUser?.uid){
            let docRef = db.collection("Users").document(uid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print(dataDescription)
                    let email = document["Email"] as? String
                    self.usermodeli.email = "\(email!)"
                    print(self.usermodeli.email!)
                    print("Document data: \(dataDescription)")
                } else {
                    print("Docu bulunamadı")
                }
            }
        }else{
            print("User bulunamadı")
        }
    }
    
    @IBAction func hidemevcutsifre(_ sender: Any) {
        mevcutSifre.isSecureTextEntry.toggle()
        if mevcutSifre.isSecureTextEntry {
            let image = UIImage(systemName: "eye.slash")
            hidemevcutsifre.setImage(image, for: .normal)
        }
        else {
            
            let image = UIImage(systemName: "eye")
            hidemevcutsifre.setImage(image, for: .normal)
        }
    }
    
    @IBAction func yeniSifre(_ sender: Any) {
        
        if yeniSifre.isSecureTextEntry == false
        {
            yeniSifreTekrar.text = yeniSifre.text
        }
        else
        {
            
        }
    }
    @IBAction func hideYeniSifre(_ sender: Any) {
        yeniSifre.isSecureTextEntry.toggle()
        if yeniSifre.isSecureTextEntry {
            let image = UIImage(systemName: "eye.slash")
            hideYeniSifre.setImage(image, for: .normal)
            yeniSifreTekrar.isHidden = false
            yeniSifreTekrarLabel.isHidden = false
        }
        else {
            let image = UIImage(systemName: "eye")
            hideYeniSifre.setImage(image, for: .normal)
            yeniSifreTekrar.isHidden = true
            yeniSifreTekrarLabel.isHidden = true
        }
    }
    

    
    func sifredegistir(email: String, currentPassword: String, newPassword: String, completion:(Error?)->Void ){
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { [self] (result, error) in
            if let error = error {
                
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    //                    self.alertUser(of: errCode)
                    let hataMesaji = passwordmodel.alertUser(of: errCode)
                    //                    HATALAR MODEL ÜZERİNDE TUTULDU
                    let alert = UIAlertController(title: "Hata", message: hataMesaji, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                    if let error = error {
                        if let errCode = AuthErrorCode(rawValue: error._code) {
                            //                    self.alertUser(of: errCode)
                            let hataMesaji = passwordmodel.alertUser(of: errCode)
                            //                    HATALAR MODEL ÜZERİNDE
                            if hataMesaji == ""
                            {
                            let alert = UIAlertController(title: "Başarılı", message: "Şifreniz başarıyla değiştirildi.", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                                self.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            }
                            else
                            {
                                let alert = UIAlertController(title: "Hata", message: hataMesaji, preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                                    self.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                })
            }
        })
    }
    
    func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
    }
    
   
    @IBAction func kaydetButtonClicked(_ sender: Any) {
        // kaydetme işlemleri yapılacak
        
        let gecerlisifre = mevcutSifre.text
        let yenisifre = yeniSifre.text
        let yenisifretekrar = yeniSifreTekrar.text
        
        passwordmodel.sifre = (gecerlisifre)!
        passwordmodel.yenisifre = (yenisifre)!
        passwordmodel.yenisifretekrar = (yenisifretekrar)!
        
        let durum = passwordmodel.validasyon(sifre: gecerlisifre!, yenisifre: yenisifre!, yenisifretekrar: yenisifretekrar!)
//        ŞİFRELERİN AYNI OLUP OLMADIĞI MODEL ÜZERİNDEN KONTROL EDİLDİ
        if (durum == true) {
            
            print(yeniSifreTekrar.text!)
            self.sifredegistir(email: usermodeli.email! , currentPassword: (passwordmodel.sifre)!, newPassword: (passwordmodel.yenisifre)!) { (error) in
                if error != nil {
                    print("hata")
                }
                else {
                    print("başarılı")
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Başarısız", message: "Lütfen yeni şifrenizi tekrarını doğru giriniz", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //        self.dismiss(animated: true, completion: nil)
    }

   
}
