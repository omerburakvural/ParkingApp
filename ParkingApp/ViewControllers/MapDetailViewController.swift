//
//  MapDetailViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit

class MapDetailViewController: UIViewController {

    @IBOutlet weak var stackViewSolListe: UIStackView!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var odemeKabulLabel: UILabel!
    @IBOutlet weak var lpgkabulLabel: UILabel!
    @IBOutlet weak var otoparkTipiLabel: UILabel!
    @IBOutlet weak var kapasiteLabel: UILabel!
    
    @IBOutlet weak var rotaCizButon: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 15.0
        rotaCizButon.layer.cornerRadius = 10.0
    }
}
