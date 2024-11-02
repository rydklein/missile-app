//
//  Server.swift
//  MissileGame
//
//  Created by Ryder Klein on 11/2/24.
//
import Foundation
import SwiftData

class ServerManager {
    public static let shared = ServerManager()
    
    public let attackLocations: [AttackLocationModel] = []
    
    public func refreshAttackLocations() async {
        
    }
    
    public func sendUserMissilesToServer(_ missiles: [AttackLocationModel]) {
        
    }
}


struct UserUpdatePayload: Codable {
    var deviceIdentifier: String
    var deviceToken: String?
    var userName: String?
}
