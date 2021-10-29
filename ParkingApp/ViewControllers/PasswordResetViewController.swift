//
//  PasswordEditViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 29.10.2021.
//

import Foundation
import UIKit

class PasswordResetViewController: UIViewController{
    
    @IBOutlet weak var mevcutSifre: UITextField!
    @IBOutlet weak var yeniSifre: UITextField!
    @IBOutlet weak var yeniSifreTekrar: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func kaydetButtonClicked(_ sender: Any) {
        // kaydetme işlemleri yapılacak
        self.dismiss(animated: true, completion: nil)
    }
}
