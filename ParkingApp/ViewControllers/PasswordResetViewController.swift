//
//  PasswordEditViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 29.10.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class PasswordResetViewController: UIViewController{
    
    @IBOutlet weak var mevcutSifre: UITextField!
    @IBOutlet weak var yeniSifre: UITextField!
    @IBOutlet weak var yeniSifreTekrar: UITextField!
    var passwordmodel = PasswordChangeModel()
    var usermodeli = NewUserViewModel()
    var db: Firestore!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
               
               Firestore.firestore().settings = settings
               // [END setup]
               db = Firestore.firestore()
                let uid = (Auth.auth().currentUser?.uid)!
                let docRef = db.collection("users").document(uid)
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
    }
    func sifredegistir(email: String, currentPassword: String, newPassword: String, completion:(Error?)->Void ){
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { [self] (result, error) in
            if let error = error {
               
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    self.alertUser(of: errCode)
                }
                
                
            }
            else {
                Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                    let alert = UIAlertController(title: "Başarılı", message: "Şifreniz başarıyla değiştirildi.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                        self.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                    
//                    self.present(alert, animated: true, completion: nil)
                })
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
//                    self.dismiss(animated: true, completion: nil)
//                    print("başarılıııı")
//                }
                
                
            }
        })
    }
   
    func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
        }
    
    func validasyon (yenisifre:String, yenisifretekrar:String) -> Bool
    {
        if ( yenisifre == yenisifretekrar)
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    @IBAction func kaydetButtonClicked(_ sender: Any) {
        // kaydetme işlemleri yapılacak
        
        let gecerlisifre = mevcutSifre.text
        let yenisifre = yeniSifre.text
        let yenisifretekrar = yeniSifreTekrar.text
        
        passwordmodel.sifre = (gecerlisifre)!
        passwordmodel.yenisifre = (yenisifre)!
        passwordmodel.yenisifretekrar = (yenisifretekrar)!
        

        let durum = validasyon(yenisifre: passwordmodel.yenisifre ?? "", yenisifretekrar: passwordmodel.yenisifretekrar ?? "")
        if (durum == true)
        {
            

            print(yeniSifreTekrar.text!)
            self.sifredegistir(email: usermodeli.email! , currentPassword: (passwordmodel.sifre)!, newPassword: (passwordmodel.yenisifretekrar)!) { (error) in
                if error != nil {
                  print("hata")
                    }
                    else {
                       print("başarılı")
                    }
                }
            
            
            
        }
        else
        {
           
            let alert = UIAlertController(title: "Başarısız", message: "Lütfen yeni şifrenizi tekrarını doğru giriniz", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        
//        self.dismiss(animated: true, completion: nil)
        
       
    }
//    HATA KONTROLÜ VE ALERTLER
    func alertUser(of errorCode: AuthErrorCode) {
        switch errorCode {
        case .internalError:
            let alert = UIAlertController(title: "Başarısız", message: "Uygulamada teknik problem mevcut", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .keychainError:
            print("Keychain Hatası")
        case .networkError:
            let alert = UIAlertController(title: "Başarısız", message: "Lütfen internet bağlantınızı kontrol ediniz", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .weakPassword:
            let alert = UIAlertController(title: "Başarısız", message: "Zayıf şifre. Lütfen 6 karakterden fazla şifre giriniz", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .wrongPassword:
            let alert = UIAlertController(title: "Başarısız", message: "Mevcut şifreyi doğru giriniz", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        default:
            let alert = UIAlertController(title: "Başarısız", message: "Bilinmeyen hata !", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
