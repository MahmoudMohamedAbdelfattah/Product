//
//  AddressViewController.swift
//  MvcProduct
//
//  Created by Mahmoud on 29/07/2022.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import Reachability

class AddressViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate , UITextFieldDelegate,PasseName {

// MARK:- IBOutlets
    @IBOutlet weak var imageAnimation: UIImageView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var famousPlaceTxt: UITextField!
    @IBOutlet weak var addressDetailsTxt: UITextField!
    @IBOutlet weak var nameArea: UILabel!
    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameRegion: UILabel!
    @IBOutlet weak var placeName: UIButton!
    @IBOutlet weak var stackData: UIStackView!
    
// MARK:- Variables
    //let locationManager = CLLocationManager()
    var locationManager : CLLocationManager!

    private var getDataPersonal = Component.signal.getInfoUser()
    private var placeNameAddress:String?
    private var latitude : Double?
    private var longitude : Double?
 //   var reachability = Reachability()

// MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self // or connect in storyboard
//        locationManager.delegate =  self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        checkAuth()
    
        // check if location /gps enabled or not
        if CLLocationManager.locationServicesEnabled() {
            print("Location Enabled")
            locationManager.startUpdatingLocation()
        } else {
            print("Location Not Enabled")
        }
        
        borderSaveButton()
        borderStackData()
     //   let ZoomRang = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000)
      //  mapView.setCameraZoomRange(ZoomRang, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageAnimation.alpha = 1
        

//

        Component.signal.basicAnimationLoaginRegistration(image: imageAnimation)
     }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
//     func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//
//        getLocationInfo(location: CLLocation(latitude: mapView.centerCoordinate.longitude, longitude: mapView.centerCoordinate.latitude))
//        let coordinate = CLLocationCoordinate2DMake(mapView.region.center.latitude, mapView.region.center.longitude)
//
//         }
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
          let center = genrateloction(for: mapView)
                   let geodecoder = CLGeocoder()
                   guard center.distance(from: previosloction ?? CLLocation())  > 50 else {
                       return
                   }
                   previosloction = center
                   geodecoder.reverseGeocodeLocation(center) { [weak self](placemark, error) in
                       guard let _ = self else{return}
                       if let _ = error{
                           return
                       }
                       guard let placemar=placemark?.first else{
                           return
                       }
                       self?.nameArea?.text = placemar.name ?? ""
                       self?.nameCountry?.text = placemar.country
                       self?.latitude = center.coordinate.latitude
                       self?.longitude = center.coordinate.longitude
                       self?.nameRegion?.text = placemar.administrativeArea
                       let streetnamber = placemar.subThoroughfare ?? ""
                       let streetname = placemar.thoroughfare ?? ""
                       DispatchQueue.main.async {
                        print("\(streetnamber )  \(streetname )  \(placemar.country ?? "")  \(placemar.administrativeArea ?? "")  \(placemar.locality ?? "")  \(placemar.subLocality ?? "") \(placemar.name ?? "" )")
                       }
                      
                   }
               }

    func centerviewonuser(){
            if let loction = locationManager.location?.coordinate{
               
                let region = MKCoordinateRegion.init(center: loction, latitudinalMeters: 100, longitudinalMeters: 100)
                mapView.setRegion(region, animated: true)
            }
        }
    func checkAuth(){
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                starttrackinguserlocation()
               
            case .denied:
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                break
            case .authorizedAlways:
                break
           
             default:
            break
            }
        }
        var loctiones = [CLLocation]()
        var previosloction:CLLocation?
        func starttrackinguserlocation(){
            mapView.showsUserLocation = true
            centerviewonuser()
            locationManager.startUpdatingLocation()
            previosloction=genrateloction(for: mapView)
           
        }
    
    func showUserSettings() {
            guard let urlGeneral = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            UIApplication.shared.open(urlGeneral)
        }

        func genrateloction(for mapview:MKMapView)->CLLocation{
            let lat=mapview.centerCoordinate.latitude
            let long=mapview.centerCoordinate.longitude
            return CLLocation(latitude: lat, longitude: long)
        }
//    private func getLocationInfo(location : CLLocation) {
//
//        let geCoder = CLGeocoder()
//        geCoder.reverseGeocodeLocation(location) { places, eroore in
//            guard let place = places?.first , eroore == nil else{return}
//                self.nameArea?.text = place.name
//                self.nameCountry?.text = place.country
//                self.latitude = location.coordinate.latitude
//                self.longitude = location.coordinate.longitude
//                self.nameRegion?.text = place.administrativeArea
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        // Get Current Location
//        guard let userlocation = locations.first  else {return}
//        render(userlocation)
//
//        // get latitude and langitiude
//        let latitude = userlocation.coordinate.latitude
//        let langitude = userlocation.coordinate.longitude
//
////        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: langitude))
////            mapView.setRegion(region, animated: true)
//        // Set UI Lable
//     //   langtituelbl.text = "\(langitude)"
//      //  Latitutelbl.text = "\(latitude)"
//        // Get Address
//       let gecoder = CLGeocoder()
//        gecoder.reverseGeocodeLocation(userlocation){ (placemarks , error) in
//            if (error != nil) {
//                print("Errore in reverseGeocodeLocation")
//            }
//            let placemark = placemarks as? [CLPlacemark]
//            if placemark?.count ?? 0 > 0 {
//                let placemark = placemarks![0]
//                let loclity = placemark.locality ?? ""
//                print(loclity)
//                let adminestrative = placemark.administrativeArea ?? ""
//                print(adminestrative)
//                let country = placemark.country ?? ""
//                print(country)
//
//                // set UI
//              //  self.addressLbl.text = "Address\(loclity) , \(adminestrative) ,\(country)"
//
//                self.nameArea?.text = placemark.name
//                self.nameCountry?.text = placemark.country
//                self.latitude = userlocation.coordinate.latitude
//                self.longitude = userlocation.coordinate.longitude
//                self.nameRegion?.text = "\(adminestrative) , \(loclity)"
//
//        }
//            self.locationManager.stopUpdatingLocation()
//    }
//  }
  
    func render (_ location : CLLocation) {
        let coordinat = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinat, span: span)
        mapView.setRegion(region, animated: true)

           let ZoomRang = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 900)
           mapView.setCameraZoomRange(ZoomRang, animated: true)

//        let pin = MKPointAnnotation()
//        pin.coordinate = coordinat
//        mapView.addAnnotation(pin)
     }
//
    internal func NameCity(name: String) {
        placeName.setTitle(name, for: .normal)
        self.placeNameAddress = name
    }
    
    private func borderSaveButton() {
        buttonSave.layer.cornerRadius = 10
        buttonSave.layer.borderWidth = 1.5
        buttonSave.layer.borderColor = UIColor.black.cgColor
        buttonSave.clipsToBounds = true
    }
    private func borderStackData() {
        stackData.layer.cornerRadius = 10
        stackData.layer.borderWidth = 1.5
        stackData.layer.borderColor = UIColor.white.cgColor
        stackData.clipsToBounds = true
    }
    
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)

    }
 
    
// MARK:- Actions
    @IBAction func PlaceNameButton(_ sender: UIButton) {
 
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectNameLocationVC") as! SelectNameLocationVC
        vc.delegate = self
         vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }

    @IBAction func SaveButton(_ sender: UIButton) {
        
        guard let FamousPlace = famousPlaceTxt?.text , !FamousPlace.isEmpty else {
             Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل اقرب مكان مشهور ", MyViewController: self)
             return
         }
        guard let nameAddress = placeNameAddress , !nameAddress.isEmpty else {
             Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل المكان المفضل", MyViewController: self)
             return
         }
         guard let AddressDetails = addressDetailsTxt?.text , !AddressDetails.isEmpty else {
             Component.signal.showCustomeErroreAlert(Message: "من فضلك ادخل العنوان بالتفصيل", MyViewController: self)
             return
         }

        let apiToken =  getDataPersonal.data!.token!

        let header : HTTPHeaders = ["Authorization":"\(apiToken)","lang":"ar", "Content-Type" : "application/json" ]
        print("///////////")

        NetworkFunc.fetchData(url: URLApi.NewAddress, parameter:["name":nameAddress,"city":  self.nameCountry!.text ?? "" ,"region":self.nameArea!.text ?? "","details":AddressDetails,"notes":FamousPlace,"latitude":self.latitude ?? 0,"longitude":self.longitude ?? 0], methode: .post, encode: JSONEncoding.default, Header: header, responseClass: RegisterModule.self) { response in
            switch response {
            case .success(let users):
                if users?.status == true {
                     Component.signal.showCustomeSucessAlert(Message: users?.message ?? "", MyViewController: self)
                   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                        let loginVC = UIStoryboard(name:"All" ,bundle: nil)
                        let new = loginVC.instantiateViewController(withIdentifier: "TabBarVC")
                        self.navigationController?.pushViewController(new, animated: true)
                        self.navigationController?.navigationBar.isHidden=true
                      }
                }
                else {
                    Component.signal.showCustomeErroreAlert(Message: users?.message ?? "", MyViewController: self)
                }
            case .failure(_):
                 print("ERROR")
            }
        }
    }
    
}

//extension UIResponder {
//
//    private struct Static {
//        static weak var responder: UIResponder?
//    }
//
//    /// Finds the current first responder
//    /// - Returns: the current UIResponder if it exists
//    static func currentFirst() -> UIResponder? {
//        Static.responder = nil
//        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
//        return Static.responder
//    }
//
//    @objc private func _trap() {
//        Static.responder = self
//    }
//}


extension AddressViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let loction = locations.last else{return}
        loctiones=locations
        render(loctiones.first!)
        locationManager.stopUpdatingLocation()
//        let center = CLLocationCoordinate2D(latitude: loction.coordinate.latitude, longitude: loction.coordinate.longitude)
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        print(loction.coordinate)
//        mapkit.setRegion(region, animated: true)
      }
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
          checkAuth()
      }
}
