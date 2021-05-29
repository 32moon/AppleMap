//
//  ViewController.swift
//  AppleMap
//
//  Created by 이문정 on 2021/05/29.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var locationInfoLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationInfoLabel.text = ""
        locationLabel.text = ""
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
    }
    
    @IBAction func changeLocationSg(_ sender: UISegmentedControl) {
    }
    

}

