//
//  SecondViewController.swift
//  map
//
//  Created by Sergiy SHILINGOV on 10/8/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    @IBAction func searchBtn(_ sender: Any) {
        let coordinates = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        map.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        locationManager.delegate = self
        // определяем precision для геолокации
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // запрашиваем геолокацию
        locationManager.requestWhenInUseAuthorization()
        // we will ask it to start updating the position
        locationManager.startUpdatingLocation()

        for location in Data.places {
            
            let latitude = location.0
            let longitude = location.1
            
            let span : MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region : MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            map.setRegion(region, animated: true)
            
            // Create annotation
            let annotation = MKPointAnnotation()
            annotation.title = location.3
            annotation.subtitle = location.4
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            self.map.addAnnotation(annotation)
            self.map.showsUserLocation = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let latitude = Data.places[Data.active].0
        let longitude = Data.places[Data.active].1
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region : MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
    }
    
    @IBAction func SegAction(_ sender: UISegmentedControl!) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            map.mapType = .standard
        case 1:
            map.mapType = .satellite
        default:
            map.mapType = .hybrid
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        
        var view: MKPinAnnotationView
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -8, y: 5)
        switch (annotation as! MKPointAnnotation).title! {
        case "Ecole 42":
            view.pinTintColor = .red
        case "UNIT Factory":
            view.pinTintColor = .green
        case "42 Silicon Valley":
            view.pinTintColor = .blue
        default:
            view.pinTintColor = .orange
        }
        return view
    }
}

