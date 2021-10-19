//
//  LoginViewController.swift
//  LoginWithFullPicture
//
//  Created by PCMACEGITIM on 16.10.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var girisButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cardView
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = CGSize (width: 10, height: 10)
        // girisButton
        girisButton.layer.cornerRadius = 10.0
    }


}

