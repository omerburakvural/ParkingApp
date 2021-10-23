//
//  MainMapViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit
import MapKit
import CoreLocation

class MainMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let visibleRadiusForUser: Double = 2000.0
    let regionRadius: Double = 8000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    
    @IBAction func editProfileButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserEdit", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "userEdit") as? UserEditViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func dummyPinButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MapDetail", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "mapDetail") as? MapDetailViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuth()
        }else{
            // show alert to user for enabling location services
        }
    }
    
    func centerViewUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: visibleRadiusForUser, longitudinalMeters: visibleRadiusForUser)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func centerGeneralArea(){
        let location = CLLocationCoordinate2D(latitude: 41.013393, longitude: 29.047944)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
    
    func checkLocationAuth(){
        switch CLLocationManager.authorizationStatus(){
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            mapView.showsUserLocation = false
            centerGeneralArea()
            let deniedAlert = UIAlertController(title: "Uyarı!!!", message: "Konum izniniz olmadığı için sadece haritadan kayıtlı otoparkları görüntüleyebilirsiniz.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
            deniedAlert.addAction(ok)
            self.present(deniedAlert, animated: true, completion: nil)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewUserLocation()
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView?.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth()
    }
    
}
