import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationModel: LocationList!
    
    @IBOutlet weak var mapView: MKMapView!
    var visited = [Location]()
    var notVisited = [Location]()
    let locationManager = CLLocationManager()
    @IBOutlet var otherTableView: LocationTableViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addWaypoint(longGesture:)))
        mapView.addGestureRecognizer(longPress)
        
        
        let noLocation = CLLocationCoordinate2D()
        _ = MKCoordinateRegion(center: noLocation, latitudinalMeters: 700, longitudinalMeters: 700)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        moveToCurrentLocation()
    }
    
    //permissions to use users location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            moveToCurrentLocation()
        } else {
            let alert = UIAlertController(title: "Can't display location", message: "Please grant permission in settings", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) -> Void in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)}))
            present(alert, animated: true, completion: nil)
        }
    }
    
    //Loads app to show users current location
    func moveToCurrentLocation() {
        if let location = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 700, longitudinalMeters: 700)
            mapView.setRegion(viewRegion, animated: false)
            
            //mapView.setCenter(location.coordinate, animated: true)
        }
    }

    //Add current location pin
    @IBAction func addCurrentLocation(_ sender: Any) {
        print(locationModel)
        //if let location = locationManager.location {
          //  let annotation = MKPointAnnotation()
           // annotation.coordinate = location.coordinate
          //  mapView.addAnnotation(annotation)
        }
   // }
    @objc func addWaypoint(longGesture: UIGestureRecognizer) {
        let wayAnnotation = MKPointAnnotation()
        let touchPoint = longGesture.location(in: mapView)
        let wayCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        _ = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)
        wayAnnotation.coordinate = wayCoords
        mapView.addAnnotation(wayAnnotation)
        
        
        let alert = UIAlertController(title: "Have you been here before?", message: "", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            //If yes is pressed
            print("you pressed Yes")
            let lat = wayCoords.latitude
            let long = wayCoords.longitude
            let location = Location(lat: lat, long: long, visited: true)
            let index = self.locationModel.add(location)
            let indexPath = IndexPath(row: index, section: 0)
            self.otherTableView.tableView.insertRows(at: [indexPath], with: .automatic)
            //self.locationModel.locations.append(location)
        })
        
        let noButton = UIAlertAction(title: "No", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            //if no is pressed
            let lat = wayCoords.latitude
            let long = wayCoords.longitude
            let location = Location(lat: lat, long: long, visited: false)
            let index = 0//self.locationModel.add(location)
            let indexPath = IndexPath(row: index, section: 0)
            self.otherTableView.tableView.insertRows(at: [indexPath], with: .automatic)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
}

