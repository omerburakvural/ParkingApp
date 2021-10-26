//
//  UserDetailViewModel.swift
//  MathQuiz
//
//  Created by Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu] on 24.10.2021.
//  Copyright © 2021 Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu]. All rights reserved.
//

import Foundation
import UIKit

public struct Userdetail: Codable {
    let Name: String
    let Surname: String
    let Email: String

}





enum SaveResult {
    case updated (UserDetailModel)
    case error
}

class UserDetailModel {
    var userName: String = ""
    var email: String = ""
    var plate: String = ""
    
    
}

class UserInfo {
    var title: String = ""
    var value: String = ""
}

class UserDetailViewModel {
    
    var list: [UserInfo] = []
    
    var user: UserDetailModel?    
    init (user: UserDetailModel? = nil) {
        self.user = user
        if let user = user {
          let emailInfo = UserInfo()
            emailInfo.title = "E-mail"
            emailInfo.value = user.email
            self.list.append(emailInfo)
            
            let plateInfo = UserInfo()
            plateInfo.title = "Plaka"
            plateInfo.value = user.plate
              self.list.append(plateInfo)
        } else {
            //            firebase çağrısı
            let emailInfo = UserInfo()
              emailInfo.title = "E-mail"
              emailInfo.value = "aytekinaf@gmail.com"
              self.list.append(emailInfo)
              
              let plateInfo = UserInfo()
              plateInfo.title = "Plaka"
              plateInfo.value = "34 AAA 34"
                self.list.append(plateInfo)
        }
        
        
    }
    
    var name: String {
        user?.userName ?? ""
    }
    var email: String {
        user?.email ?? ""
    }
    var plate: String {
        user?.plate ?? ""
    }
    
    
    func saveUserName (withName name: String?) -> SaveResult {
        
        if let strongName = name{
            user!.userName = strongName
            return .updated(user!)
            // firebase'e yaz
        } else {
            return .error
        }
    }
    
    
    
}

