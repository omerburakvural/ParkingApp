//
//  MapDetailViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit

class MapDetailViewController: UIViewController {

    @IBOutlet weak var stackViewSolListe: UIStackView!
    
    @IBOutlet weak var stackViewSagVeriler: UIStackView!
    
    @IBOutlet weak var fiyatLabel: UILabel!
    
    
    @IBOutlet weak var odemeKabulLabel: UILabel!
    @IBOutlet weak var lpgkabulLabel: UILabel!
    @IBOutlet weak var otoparkTipiLabel: UILabel!
    @IBOutlet weak var kapasiteLabel: UILabel!
    
    @IBOutlet weak var rotaCizButon: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 15.0
        
        if traitCollection.userInterfaceStyle == .dark
        {
            view.backgroundColor = .systemGray
            rotaCizButon.backgroundColor = .systemGray
            rotaCizButon.tintColor = .black
//            kayitButon.backgroundColor = .systemGray
        }
        else
        {
            view.backgroundColor = UIColor(red: 4/255.0, green: 159/255.0, blue: 217/255.0, alpha: 1)
        }
        // Do any additional setup after loading the view.
    }


}
