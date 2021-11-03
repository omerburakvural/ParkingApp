//
//  PasswordChangeModel.swift
//  ParkingApp
//
//  Created by PCMACEGITIM on 29.10.2021.
//

import Foundation
import Firebase
import FirebaseAuth

class PasswordChangeModel : Codable

{
    
        var sifre:String?
        var yenisifre:String?
        var yenisifretekrar:String?
    
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
            returnstring = "Keychain Hatası"
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
    
    func validasyon (yenisifre:String, yenisifretekrar:String) -> Bool
    {
        if ( yenisifre == yenisifretekrar) && (sifre != yenisifre)
        {
         return true
            
        }
        else
        {
            return false
        }
    }

}
