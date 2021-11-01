//
//  LoginViewModel.swift
//  ParkingApp
//
//  Created by Zeynep Zincirli on 12.10.2021.
//

import Foundation

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
}
