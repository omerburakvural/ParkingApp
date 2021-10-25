//
//  UserDetailCell.swift
//  MathQuiz
//
//  Created by Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu] on 24.10.2021.
//  Copyright © 2021 Ahmet Furkan Aytekin [Uygulama Gelistirme - Kurum Ici Uygulamalar Bolumu]. All rights reserved.
//

import Foundation
import UIKit

class UserDetailCell : UITableViewCell {
    
    @IBOutlet weak var keyLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    

    
    var viewModel: UserCellViewModel! {
        didSet {
            keyLbl.text = viewModel.user?.key
            valueLbl.text = viewModel.user?.value
            }
        }
    }

