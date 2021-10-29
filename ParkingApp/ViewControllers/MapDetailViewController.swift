//
//  MapDetailViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit
import MapKit

class MapDetailViewController: UIViewController {

    @IBOutlet weak var stackViewSolListe: UIStackView!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var odemeKabulLabel: UILabel!
    @IBOutlet weak var lpgkabulLabel: UILabel!
    @IBOutlet weak var otoparkTipiLabel: UILabel!
    @IBOutlet weak var kapasiteLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var rotaCizButon: UIButton!
    
    var pin = ParkModel.init(id:"", capacity: 0, has_vale: true, long: 0.0, lat: 0.0, lpg_availability: true, park_name: "", park_type: "", payment_type: "", price: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 15.0
        rotaCizButon.layer.cornerRadius = 10.0
        navBar.layer.cornerRadius = 15.0
        navBar.clipsToBounds = true
        navBarTitle.title = pin.park_name
        fiyatLabel.text = "\(pin.price) TL"
        odemeKabulLabel.text = pin.payment_type
        kapasiteLabel.text = "\(pin.capacity)"
        otoparkTipiLabel.text = pin.park_type
    }
}
