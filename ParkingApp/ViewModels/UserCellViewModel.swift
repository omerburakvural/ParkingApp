//
//  UserCellViewModel.swift
//  MathQuiz
//
//  Created by Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu] on 24.10.2021.
//  Copyright © 2021 Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu]. All rights reserved.
//

import Foundation

/*class Detail{
 var key: String = ""
 var value: String = ""
 }*/
class UserCellDetail {
    internal init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    var key: String
    var value: String
}

class UserCellViewModel {
    
    var user: UserCellDetail?
    
    init (user: UserCellDetail? = nil) {
        self.user = user
    }
}
