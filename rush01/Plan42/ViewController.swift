//
//  ViewController.swift
//  Plan42
//
//  Created by Vladislav MIACHKOV on 10/13/18.
//  Copyright © 2018 Vladislav MIACHKOV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var r = true
    @IBOutlet weak var mapView: MKMapView!
    let location_manager = CLLocationManager()
    var curr_location = false
    @IBOutlet weak var destinationLabel: UITextField!
    @IBOutlet weak var sourceLabel: UITextField!
    let annotation1 = MKPointAnnotation()
    let annotation2 = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationLabel.text = ""
        sourceLabel.text = ""
        location_manager.delegate = self
        location_manager.desiredAccuracy = kCLLocationAccuracyBest
        location_manager.requestWhenInUseAuthorization()
        location_manager.startUpdatingLocation()
      
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func allertMessage(_ message: String)
    {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func findBUtton(_ sender: UIButton)
    {
        mapView.removeOverlays(mapView.overlays)
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        if destinationLabel.text == "" && sourceLabel.text != "" {
            getPlace()
        }
        else if (destinationLabel.text != "" && sourceLabel.text != "") {
            drawRoute()
        }
        else if (destinationLabel.text != "" && sourceLabel.text == "")
        {
            allertMessage("Source is empty")
            print("You have destination but have source")
            print("if you want to find place, just swap destination and source")
        }
        else
        {
            allertMessage("Fields are empty")
            print("Error, fields are empty") // have to create alert
        }
    }
    
    
    @IBAction func currentLocationButton(_ sender: UIButton) // get location and fill sourceLabel with location
    {
        location_manager.startUpdatingLocation()
        curr_location = true
        print("get location")
        mapView.removeOverlays(mapView.overlays)
        let allAnnotations = mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
    }
    
    func drawRoute() // call if destinaton not empty
    {
        var location1: CLLocation?
        var location2: CLLocation?
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.async {
        let geoCoder1 = CLGeocoder()
            geoCoder1.geocodeAddressString(self.sourceLabel.text!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                
                else {
                    // handle no location found
                     self.allertMessage("Couldn't find source location")
                    self.r = false
                 
                    return
            }
            print("source :\(location.coordinate.latitude) \(location.coordinate.longitude)")
            
            location1 = location
        }
        
        let geoCoder2 = CLGeocoder()
            geoCoder2.geocodeAddressString(self.destinationLabel.text!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                
                else {
                    // handle no location found
                    //create alert
                    self.r = false
                     self.allertMessage("Couldn't find destination location")
                    print("Couldn't find destination  location ")
                    return
            }
            print("destination:\(location.coordinate.latitude) \(location.coordinate.longitude)")
           
             location2 = location
            group.leave()
            }
        }
        group.notify(queue: .main)
        {
            if self.r == true
        {
            if location1?.coordinate != nil && location2?.coordinate != nil
            {
                self.renderDestination(sourceCoordinates: (location1?.coordinate)!, destCoordinates: (location2?.coordinate)!)
                self.createPin(annotation: self.annotation1, (location1?.coordinate)!, title: "Source", subtitle: "")
                self.createPin(annotation: self.annotation2, (location2?.coordinate)!, title: "Destination", subtitle: "")
            }
        }
            self.r = true
        }
    }
    
    
    func renderDestination(sourceCoordinates : CLLocationCoordinate2D, destCoordinates : CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        //        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            guard let response = response else {
                if let error = error {
                    print (error)
                    self.allertMessage("Directions are not available between these locations.")
                    let allAnnotations = self.mapView.annotations
                    self.mapView.removeAnnotations(allAnnotations)
                    print("Something Went Wrong")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            let rekt = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    func getPlace() // call if destination and source are not empty
    {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(sourceLabel.text!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                
                else {
                    // handle no location found
                    self.allertMessage("Couldn't find location")
                    print("Couldn't find location")
                    return
            }
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            self.createPin(annotation: self.annotation1, location.coordinate, title: "", subtitle: "")
            self.moveToLocation(location.coordinate)
        }
    }

    func moveToLocation(_ location: CLLocationCoordinate2D) {
        
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
    }
    
    func createPin(annotation: MKPointAnnotation,_ location: CLLocationCoordinate2D, title: String, subtitle: String) {
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        annotation.title = title
        annotation.subtitle = subtitle
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if curr_location == true {
            let location = locations[0]
            
            let span : MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            print("Location updated")
            location_manager.stopUpdatingLocation()
        }
        
    }
}

