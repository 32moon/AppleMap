//
//  ViewController.swift
//  AppleMap
//
//  Created by 이문정 on 2021/05/29.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
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
    // 위도, 경도로 위치 표시
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    // 핀 설치하기
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치가 업데이트 되었을 때 지도에 위치 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        // 위도와 경도의 값으로 주소 찾기
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemark, erro) -> Void in
            guard let pm = placemark?.first else { return }
//            let pm = placemark!.first
            let country = pm.country
            var address: String = country!
            if pm.locality != nil {
                address += " "
                address += pm.locality!
            }
            if pm.thoroughfare != nil {
                address += " "
                address += pm.thoroughfare!
            }
            self.locationInfoLabel.text = "현재 위치"
            self.locationLabel.text = address
        })
        
        locationManager.stopUpdatingLocation()
    }
    
    // 37.32902992914243, 127.09114772662738
    // 37.50367880316756, 127.02691984653913
    @IBAction func changeLocationSg(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.locationInfoLabel.text = ""
            self.locationLabel.text = ""
            locationManager.startUpdatingLocation()
            self.myMap.showsUserLocation = true
            
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 37.32902992914243, longitudeValue: 127.09114772662738, delta: 0.1, title: "우리집", subtitle: "경기도 용인시 수지구 수풍로47")
            self.locationInfoLabel.text = "보고 계신 위치"
            self.locationLabel.text = "우리집"
            self.myMap.showsUserLocation = false
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 37.50367880316756, longitudeValue: 127.02691984653913, delta: 0.1, title: "정돈 강남점", subtitle: "서울특별시 강남구 강남대로 110길 26")
            self.locationInfoLabel.text = "보고 계신 위치"
            self.locationLabel.text = "정돈 강남점"
            self.myMap.showsUserLocation = false
        }
        
    }
    

}

