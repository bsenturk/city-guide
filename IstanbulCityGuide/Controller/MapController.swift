//
//  MapController.swift
//  IstanbulCityGuide
//
//  Created by Burak Şentürk on 4.03.2018.
//  Copyright © 2018 Burak Şentürk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapController: UIViewController , CLLocationManagerDelegate {
    var name : String?
    var lat : Double?
    var lng : Double?

    var touristicVenues : TouristicVenues? {
        didSet{
//              guard let name = touristicVenues?.name else { return }
//            guard let lat = touristicVenues?.lat else { return }
//             guard let lng = touristicVenues?.lng else { return }
           

            
        }
        
    }
     let mapView = MKMapView()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    private func setupMapView(lat : Double , lng : Double , name : String){
       
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.showsScale = true
        mapView.showsCompass = true
        
        view.addSubview(mapView)
    
        let coordinate = CLLocationCoordinate2DMake(lat, lng)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupMapView(lat: lat!, lng: lng!, name: name!)
    }
}
