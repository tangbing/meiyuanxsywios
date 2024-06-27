//
//  XSLocationManager.swift
//  test_gaodeMap
//
//  Created by Tb on 2022/3/7.
//

import Foundation
import CoreLocation

typealias locationSuccessBlock = ((_ location: [CLLocation]) -> Void)?
typealias locationFailureBlock = ((_ error: Error) -> Void)?
typealias locationGeocoderBlock = ((_ geocoderArray: [CLPlacemark]?) -> Void)?

class XSLocationManager: NSObject {
     
    private var successBlock: locationSuccessBlock = nil
    private var failureBlock: locationFailureBlock = nil
    private var geocoderBlock: locationGeocoderBlock = nil

    lazy var locationManager: CLLocationManager = {
         let location = CLLocationManager()
         location.delegate = self
         location.requestWhenInUseAuthorization()
        return location
     }()
     
     static let manager: XSLocationManager = {
       let instance = XSLocationManager()
       return instance
    }()
    
    func startLocation(successBlock: locationSuccessBlock, failureBlock:  locationFailureBlock, geocoderBlock:  locationGeocoderBlock = nil) {
        
        self.locationManager.startUpdatingLocation()
        self.successBlock = successBlock
        self.failureBlock = failureBlock
        self.geocoderBlock = geocoderBlock
        
    }
    
    
}

extension XSLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        if let successHandler = successBlock {
            successHandler(locations)
        }
       
        
        if let geocoderHandler = geocoderBlock, !locations.isEmpty {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(locations.first!) { placeMarks, error in
                geocoderHandler(placeMarks)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let failureHandler = failureBlock {
            failureHandler(error)
        }
        print(error.localizedDescription)
    }
}

