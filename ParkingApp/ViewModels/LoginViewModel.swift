//
//  LoginViewModel.swift
//  ParkingApp
//
//  Created by Zeynep Zincirli on 12.10.2021.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserRemember{
    static let emailKey = "email"
    static let passwordKey = "password"
    static let rememberMeKey = "rememberMe"
}

class LoginViewModel {
    
    let defaults = UserDefaults.standard
    
    func userAuthCheck (withEmail: String, andWithPassword: String, andWithSwitch: Bool) -> Bool{
        
        if (withEmail.trimmingCharacters(in: .whitespacesAndNewlines) == "" || andWithPassword.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return false
        }else
        {
            if andWithSwitch
            {
                defaults.set(withEmail, forKey: UserRemember.emailKey)
                defaults.set(andWithPassword, forKey: UserRemember.passwordKey)
                defaults.set(true, forKey: UserRemember.rememberMeKey)
                
            }
            return true
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
        case .wrongPassword:
            returnstring = "Başka şifre seçiniz"
        default:
            returnstring = "Bilinmeyen hata"
        }
        return returnstring
    }
}
