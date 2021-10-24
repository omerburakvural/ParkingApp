//
//  MainMapViewController.swift
//  ParkingApp
//
//  Created by Omer Burak Vural on 13.10.2021.
//

import UIKit
import MapKit
import CoreLocation
import MaterialComponents

class MainMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var viewModel = MainMapViewModel()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let visibleRadiusForUser: Double = 2000.0
    let regionRadius: Double = 10000.0
    let coordinate = CLLocationCoordinate2D(latitude: 41.033393, longitude: 29.047944)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
        addCustomPin()
    }
    
    func addCustomPin(){
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Otopark"
        mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //create view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "mapPin")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let storyboard = UIStoryboard(name: "MapDetail", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "mapDetail") as? MapDetailViewController {
            vc.modalPresentationStyle = .popover
            let bottomSheet = MDCBottomSheetController(contentViewController: vc)
            self.present(bottomSheet, animated: false, completion: nil)
        }
    }
    
    @IBAction func editProfileButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserEdit", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "userEdit") as? UserEditViewController {
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
            let locationServiceAlert = UIAlertController(title: "Uyarı!!!", message: "Konum servisiniz kapalı olduğu için sadece haritadan kayıtlı otoparkları görüntüleyebiliyoruz. Rota oluşturma ve yakın çevre görüntüleme hizmetlerini ne yazık ki sunamıyoruz.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            locationServiceAlert.addAction(ok)
            self.present(locationServiceAlert, animated: true, completion: nil)
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
            let deniedAlert = UIAlertController(title: "Uyarı!!!", message: "Konum izniniz olmadığı için sadece haritadan kayıtlı otoparkları görüntüleyebiliyoruz. Rota oluşturma ve yakın çevre görüntüleme hizmetlerini ne yazık ki sunamıyoruz.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            deniedAlert.addAction(ok)
            self.present(deniedAlert, animated: true, completion: nil)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            checkForRegion()
            centerViewUserLocation()
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func checkForRegion(){
        let location = CLLocationCoordinate2D(latitude: 41.013393, longitude: 29.047944)
        let region = CLCircularRegion(center: location, radius: regionRadius, identifier: "")
        if let location = locationManager.location?.coordinate{
            if (region.contains(location)){
                
            }else{
                //                user is out of service area
                let locationServiceAlert = UIAlertController(title: "Uyarı!!!", message: "Hizmet bölgesi dışındasınız. Haritadan hizmet bölgesi içerisinde bulunan otoparkları seçip rota oluşturabilirsiniz.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                })
                locationServiceAlert.addAction(ok)
                self.present(locationServiceAlert, animated: true, completion: nil)
            }
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
