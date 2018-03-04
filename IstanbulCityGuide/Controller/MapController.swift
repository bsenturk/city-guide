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
class MapController: UIViewController {
    
    var touristicVenues : TouristicVenues? {
        didSet{
            guard let lat = touristicVenues?.lat else { return }
             guard let lng = touristicVenues?.lng else { return }
             guard let name = touristicVenues?.name else { return }
            setupMapView(lat: lat, lng: lng, name: name)
        }
        
    }
    
    private func setupMapView(lat : Double , lng : Double , name : String){
        let mapView = MKMapView()
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
    }
}
