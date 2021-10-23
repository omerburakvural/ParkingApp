//
//  LoginViewController.swift
//  LoginWithFullPicture
//
//  Created by Zeynep Zincirli on 16.10.2021.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    //deneme
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

    @IBAction func newUserButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "newUser") as? NewUserViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    
    @IBAction func noUserButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainMap", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "mainMap") as? MainMapViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
}

