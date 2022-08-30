//
//  MapViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 27/08/2022.
//

import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var langtituelbl: UILabel!
    @IBOutlet weak var Latitutelbl: UILabel!
    
    var locationManager : CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // inite location manger
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
//        let initloc = CLLocation(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
//        let region = MKCoordinateRegion(center: initloc.coordinate, latitudinalMeters: 0, longitudinalMeters: 0)
//        mapKit.setRegion(region, animated: true)
     }
    
    @IBAction func locationButton(_ sender: Any) {
        
        // Configration
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
    
        // check if location /gps enabled or not
        if CLLocationManager.locationServicesEnabled() {
            print("Location Enabled")
            locationManager.startUpdatingLocation()
        } else {
            print("Location Not Enabled")
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get Current Location
        let userlocation = locations[0] as CLLocation
        
        // get latitude and langitiude
        let latitude = userlocation.coordinate.latitude
        let langitude = userlocation.coordinate.longitude
        
    
        
        // Set UI Lable
        langtituelbl.text = "\(langitude)"
        Latitutelbl.text = "\(latitude)"
        // Get Address
       let gecoder = CLGeocoder()
        gecoder.reverseGeocodeLocation(userlocation){ (placemarks , error) in
            if (error != nil) {
                print("Errore in reverseGeocodeLocation")
            }
            let placemark = placemarks as? [CLPlacemark]
            if placemark?.count ?? 0 > 0 {
                let placemark = placemarks![0]
                let loclity = placemark.locality ?? ""
                let adminestrative = placemark.administrativeArea ?? ""
                let country = placemark.country ?? ""
               
                // set UI
                self.addressLbl.text = "Address\(loclity) , \(adminestrative) ,\(country)"
                
        }
    }
  }
}
