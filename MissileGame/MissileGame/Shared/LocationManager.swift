//
//  LocationManager.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import CoreLocation
import Foundation
import SwiftData
import MapKit

class LocationManager: NSObject, ObservableObject {
    public static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private let backgroundActivitySession = CLBackgroundActivitySession()
    private let serviceSession = CLServiceSession(authorization: .always)
    
    private var missilesInRadius: [AttackLocationModel] = []
    
    @Published var userLocation: CLLocation?
    @Published var locationAccess: LocationAccess = .unknown
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
    }
    
    func requestLocationAccess() {
        manager.requestWhenInUseAuthorization()
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
        case .restricted:
            locationAccess = .denied
        case .denied:
            locationAccess = .denied
        case .authorizedAlways:
            locationAccess = .denied
        case .authorizedWhenInUse:
            locationAccess = .inUse
        @unknown default:
            locationAccess = .denied
        }
        startFetchingCurrentLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Did fetch location")
        print (location)
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
            ServerManager.shared.sendUserMissilesToServer(locations)
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
