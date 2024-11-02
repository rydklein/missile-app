//
//  LocationManager.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import CoreLocation
import Foundation
import SwiftData

class LocationManager: NSObject, ObservableObject {
    public static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private let backgroundActivitySession = CLBackgroundActivitySession()
    private let serviceSession = CLServiceSession(authorization: .always)
    
    private var missilesInRadius: [AttackLocationModel] = []
    
    @Published var userLocation: CLLocation?
    @Published var hasLocationAccess: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationAccess() {
        manager.requestAlwaysAuthorization()
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
            hasLocationAccess = false
        case .authorized:
            hasLocationAccess = true
        @unknown default:
            hasLocationAccess = false
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
