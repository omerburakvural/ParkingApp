//
//  NewUserViewModel.swift
//  ParkingApp
//
//  Created by Adem Er on 13.10.2021.
//

import Foundation
import Firebase
import FirebaseAuth
class NewUserViewModel

{
    var name:String?
    var username:String?
    var usersurname:String?
    var email:String?
    var password:String?
    var namesurname:String?
    var plaka:String?
    var passwordagain:String?
    
    
    
    
    func validateFields(user: String, withSurname: String, withEmail: String, withPassword:String, withPasswordagain: String) -> String
    {
        if user.trimmingCharacters(in: .whitespacesAndNewlines) == "" || withSurname.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            withEmail.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            withPassword.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            withPasswordagain.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
             return  "Lütfen bilgilerinizi giriniz"
            //            bilgiler validasyon edildi
        }
        else
        {
            
            if withPassword == withPasswordagain
            //                password verisinin iki textboxta da aynı olup olmadığı kontrol edildi
            {
                
                return "problem bulunmuyor"
            }
            else
            {
                
                return "Şifreleriniz aynı olmalıdır"
            }
        }
    }
    
    
    
    func alertUser(of errorCode: AuthErrorCode) -> String {
        var returnstring:String = ""
   
        switch errorCode {
        case .appVerificationUserInteractionFailure:
            returnstring = "Uygulamada teknik problem mevcut"
            //                  Uygulamanın Firebase'de doğrulanmaması
        case .emailAlreadyInUse:
            returnstring = "Lütfen başka e-posta adresi ile kaydolunuz"
            //                  E-mail'in yeniden kaydolmaya çalışması
        case .internalError:
            returnstring = "Uygulamada teknik problem mevcut"
            //                  Internal Error
        case .invalidEmail:
            returnstring = "Geçersiz e-mail adresi"
            //                  Yanlış e-mail girişi
        case .keychainError:
            print("Keychain Hatası")
        case .networkError:
            returnstring = "Lütfen internet bağlantınızı kontrol ediniz"
        case .weakPassword:
            returnstring = "Zayıf şifre. Lütfen 6 karakterden fazla şifre giriniz"
        default:
            returnstring = "Bilinmeyen hata"
        }
        return returnstring
    }
    
    
    
}


