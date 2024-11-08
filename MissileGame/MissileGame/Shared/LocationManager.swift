//
//  LocationManager.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import CoreLocation
import SwiftUI
import Foundation
import SwiftData
import MapKit

@Observable class LocationManager: NSObject {
    public static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private let backgroundActivitySession = CLBackgroundActivitySession()
    private let serviceSession = CLServiceSession(authorization: .always)
    
    private var missilesInRadius: [AttackLocationModel] = []
    
    var userLocation: CLLocation?
    var locationAccess: LocationAccess = .unknown
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
    }
    
    func requestLocationAccess(){
        self.requestWhenInUseAccess()
        self.requestAlwaysLocationAccess()
    }
    
    func requestWhenInUseAccess() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestAlwaysLocationAccess() {
        manager.requestAlwaysAuthorization()
    }
    
    func startFetchingCurrentLocation() {
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:
        CLAuthorizationStatus)
    {
        switch status {
        case .notDetermined:
            locationAccess = .unknown
            break
        case .restricted:
            locationAccess = .denied
            break
        case .denied:
            locationAccess = .denied
            break
        case .authorizedAlways:
            locationAccess = .always
            break
        case .authorizedWhenInUse:
            locationAccess = .inUse
            break
        @unknown default:
            locationAccess = .denied
            break
        }
        startFetchingCurrentLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
//        print("Did fetch location")
//        print (location)
        userLocation = location
        
    }
    
    func checkForLocationMatches() {
        guard let goodLocation = userLocation else {
            return
        }
        let attackLocations = SwiftDataService.shared.fetchAttackLocations()
        
        var locations: [AttackLocationModel] = []
        for location in attackLocations {
            if goodLocation.distance(from: CLLocation(latitude: location.lat, longitude: location.long)) <= Constants.MISSILE_RADIUS {
                locations.append(location)
            }
        }
        if (!locations.elementsEqual(missilesInRadius, by: {
            $0.id == $1.id
        })) {
            ServerManager.shared.sendUserInRangeMissilesToServer(locations)
        }
        missilesInRadius = locations
    }
}

enum LocationAccess {
    case unknown
    case denied
    case inUse
    case always
}
