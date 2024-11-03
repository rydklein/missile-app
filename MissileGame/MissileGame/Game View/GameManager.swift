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

@Observable class GameManager {
    public var endTime = Date(timeIntervalSinceNow: 60 * 60 * 8)
    public var myMissileLocation: CLLocationCoordinate2D?
    public var myShieldLocation: CLLocationCoordinate2D?
    public var incomingMissile: IncomingMissile?
    public var gameState: GameState = .planning
    
    public func launchMissile() {
        
    }
    
    public func placeMissile(lat: Double, long: Double) {
        
    }
    
    public func placeShield(lat: Double, long: Double) {
        
    }
}

struct IncomingMissile {
    var location: CLLocationCoordinate2D
    var arrivalTime: Date
}

enum GameState {
    case planning
    case action
}
