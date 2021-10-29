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
import FirebaseDatabase
import FirebaseFirestore

class NewUserViewController: UIViewController {
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hideButton.maximumContentSizeCategory = .small
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        kayitButon.layer.cornerRadius = 10.0
        mainView.layer.cornerRadius = 10.0
        passwordTextbox.isSecureTextEntry.toggle()
        passwordagainTextbox.isSecureTextEntry.toggle()
    }
    
    private let database = Database.database().reference()
    
    var newuserviewmodel = NewUserViewModel()
    
    @IBOutlet weak var mainView: UIView!
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
            
            
            hideButton.setImage(image, for: .normal)
            passwordagainTextbox.isHidden = false
            
        }
        else {
            //               if let image = UIImage(systemName: "eye.slash.fill") {
            //                   (sender as AnyObject).setImage(image, for: .normal)
            let image = UIImage(systemName: "eye.slash")
            //                   (sender as AnyObject).setImage(image, for: .normal)
            passwordagainTextbox.isHidden = true
            hideButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func passwordTextbox(_ sender: Any) {
        
        if passwordTextbox.isSecureTextEntry == false
        {
            passwordagainTextbox.text = passwordTextbox.text
        }
        else
        {
            
        }
        //        TEXTBOX'IN EDİTİNG CHANGED'INE YAZILDI. EĞER KULLANICI ŞİFRESİNİ GÖREREK YAZMAK İSTERSE, TEKRARLAMA TEXTBOX'I AYNI VERİLERİ ALIYOR VE VALİDASYON KISMINDA TEXTBOX KONTROLÜ SORUNSUZ GEÇİYOR
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //    GERİ BUTONU
    
    
    func valideteFields() -> String
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
            if passwordTextbox.text == passwordagainTextbox.text
            //                password verisinin iki textboxta da aynı olup olmadığı kontrol edildi
            {
                
                return "problem bulunmuyor"
            }
            else
            {
                errorLabel.text = "Şifreleriniz aynı olmalıdır"
                return "problem mevcut"
            }
        }
        
        return "deger"
    }
    
    @IBAction func kayitButon(_ sender: Any) {
        
        //        var ref: DocumentReference? = nil
        //              ref = db.collection("Users").addDocument(data: [
        //                  "Name": "FireTest1",
        //                  "Surname": "FireTest2",
        //
        //              ]) { err in
        //                  if let err = err {
        //                      print("Error adding document: \(err)")
        //                  } else {
        //                      print("Document added with ID: \(ref!.documentID)")
        //                  }
        //              }
        
        
        
        
        valideteFields()
        
        let durum = valideteFields()
        //        fonksiyondan dönen değer değişkene alındı
        if durum == "problem mevcut"
        {
            
        }
        if durum == "problem bulunmuyor"
        //            fonksiyon validasyonu sorunsuz olarak bitirdi ise sign-up işlemi başlatılıyor
        {
            
            let name = self.adTextbox.text
            let surname = self.soyadTextbox.text
            let email = self.epostaTextbox.text
            let password = self.passwordTextbox.text
            let plaka = ""
            
            newuserviewmodel.email = email
            newuserviewmodel.password = password
            newuserviewmodel.name = name
            newuserviewmodel.usersurname = surname
            newuserviewmodel.plaka = plaka
            
            
            
            Auth.auth().createUser(withEmail: newuserviewmodel.email!, password: newuserviewmodel.password!) { (user, error) in
                //email ve password değerleri ile, firebase'e auth kaydı yapılıyor
                
                
                if let error = error {
                    
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                    alertUser(of: errCode)
                    }
                }
                else
                {
                    
                    //                KAYIT BAŞARILI
                    //                ALERT VERİLDİ VE ANA SAYFAYA YÖNLENDİRECEĞİ BİLGİSİ AKTARILDI.
                    
                    
                    let alert = UIAlertController(title: "Kayıt tamamlandı", message: "İşlem başarılı. 2 saniye içinde ana sayfaya yönlendiriliyorsunuz", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.errorLabel.text = "Kayıt Başarılı. Ana sayfaya yönlendiriliyorsunuz"
                    
                    
                    let uid = (Auth.auth().currentUser?.uid)!
                    //                GEÇERLİ OTURUMUN UID BİLGİSİ ALINDI
                    //                let object : [String:Any] = [
                    //                    "Ad": self.newuserviewmodel.name! as NSObject,
                    //                    "Soyad" : self.newuserviewmodel.usersurname as Any,
                    //                    "Email" : self.newuserviewmodel.email as Any,
                    //                    ]
                    //
                    //                self.database.child("User").child(uid).setValue(object)
                    
                    
                    self.db.collection("Users").document(uid).setData([
                        "Name Surname": self.newuserviewmodel.name! + " " + self.newuserviewmodel.usersurname! as Any,
                        //                    "Surname": self.newuserviewmodel.usersurname as Any,
                        "Email": self.newuserviewmodel.email! as Any,
                        "Plaka" : self.newuserviewmodel.plaka as Any,
                        
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    //
                    //                FİREBASE DATABASE İÇİN KAYIT YAPILDI.
                    
                    
                    
                    // KARMAŞA OLMAMASI İÇİN asyncAfter BÖLÜMÜNDE 2 SANİYE BEKLETİLECEK VE ANA SAYFAYA AKTARILACAK
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        
                        Auth.auth().signIn(withEmail: self.newuserviewmodel.email!, password: self.newuserviewmodel.password!) { (user, error) in }
                        let userID = Auth.auth().currentUser?.uid
                        print("Giriş yaptık" + "\(userID)")
                        //                    GEÇERLİ UID BİLGİSİ ALINARAK SIGN-IN OLUNUYOR
                        
                        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: "mainMap") as? MapViewController {
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false, completion: nil)
                        }
                        //                      EKRAN YÖNLENDİRME YAPILIYOR.
                        
                        
                        
                        
                        //                    self.database.child("User").child(uid).observeSingleEvent(of: .value, with: { snapshot in
                        //                      // Get user value
                        //                      let value = snapshot.value as? NSDictionary
                        //                      let emailadresi = value?["Email"] as? String ?? ""
                        //                        print("Email adresimiz : " + "\(emailadresi)")
                        //                    })
                        
                        //                  FİREBASE VERİ ÇEKİMİ KODU
                        
                        
                    }
                    // 2 saniye bekleme fonksiyonu burada bitiyor
                    
                }
                
            }
            
            func alertUser(of errorCode: AuthErrorCode) {
                
                switch errorCode {
                    
                    
                case .appVerificationUserInteractionFailure:
                    errorLabel.text = "Uygulamada teknik problem mevcut"
                    //                  Uygulamanın Firebase'de doğrulanmaması
                case .emailAlreadyInUse:
                    errorLabel.text = "Lütfen başka e-posta adresi ile kaydolunuz"
                    //                  E-mail'in yeniden kaydolmaya çalışması
                case .internalError:
                    errorLabel.text = "Uygulamada teknik problem mevcut"
                    //                  Internal Error
                case .invalidEmail:
                    errorLabel.text = "Geçersiz e-mail adresi"
                    //                  Yanlış e-mail girişi
                case .keychainError:
                    print("Keychain Hatası")
                case .networkError:
                    errorLabel.text = "Lütfen internet bağlantınızı kontrol ediniz"
                case .weakPassword:
                    errorLabel.text = "Zayıf şifre. Lütfen 6 karakterden fazla şifre giriniz"
                default:
                    errorLabel.text = "Bilinmeyen hata"
                }
            }
            
        }
        
        return
        
    }
    
    
    
    
}





