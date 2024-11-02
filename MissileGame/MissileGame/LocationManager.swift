//
//  LocationManager.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var hasLocationAccess: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationAccess() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startFetchingCurrentLocation() {
        manager.startUpdatingLocation()
    }
    
    func stopFetchingCurrentLocation() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:
        CLAuthorizationStatus)
    {
        switch status {
        case .notDetermined:
            hasLocationAccess = false
        case .restricted:
            hasLocationAccess = false
        case .denied:
            hasLocationAccess = false
        case .authorizedAlways:
            hasLocationAccess = true
        case .authorizedWhenInUse:
            hasLocationAccess = true
        case .authorized:
            hasLocationAccess = true
        @unknown default:
            hasLocationAccess = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }
}
