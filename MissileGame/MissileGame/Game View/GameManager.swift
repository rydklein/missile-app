//
//  GameManager.swift
//  MissileGame
//
//  Created by Ryder Klein on 11/2/24.
//
import SwiftData
import SwiftUI
import Foundation
import MapKit

@Observable
class GameManager {
    public var endTime = Date(timeIntervalSinceNow: 60 * 60 * 8)
    public var myMissileLocation: CLLocationCoordinate2D?
    public var myShieldLocation: CLLocationCoordinate2D?
    public var healthPoints: Int = 3
    public var incomingMissile: IncomingMissile?
    public var gameState: GameState = .planning
    
    public func launchMissile() {
        if let location = myMissileLocation {
            incomingMissile = IncomingMissile(location: location, arrivalTime: .init(timeIntervalSinceNow: 60))
        }
    }
    
    public func placeMissile(lat: Double, long: Double) {
        myMissileLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    public func placeShield(lat: Double, long: Double) {
        myShieldLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

struct IncomingMissile {
    var location: CLLocationCoordinate2D
    var arrivalTime: Date
}

enum GameState: String {
    case planning
    case action
}
