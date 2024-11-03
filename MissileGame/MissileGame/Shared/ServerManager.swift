//
//  Server.swift
//  MissileGame
//
//  Created by Ryder Klein on 11/2/24.
//
import Foundation
import SwiftData
import UIKit

class ServerManager {
    public static let shared = ServerManager()
    
    public func launchMissile() {
        
    }
    
    public func placeMissile(lat: Double, long: Double) {
        
    }
    
    public func placeShield(lat: Double, long: Double) {
        
    }
    
    public func refreshAttackLocations() async {
        
    }
    
    public func sendUserInRangeMissilesToServer(_ missiles: [AttackLocationModel]) {
        
    }
    
    public func updateUser(name: String? = nil, deviceToken: String? = nil, gameId: String? = nil) async {
        guard let url = URL(string: "\(Constants.WEB_ROOT_URL)/users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = UserUpdatePayload(deviceIdentifier: getDeviceIdentifier(), deviceToken: deviceToken, name: name, gameId: gameId)
        print(payload)
        let jsonData = try! JSONEncoder().encode(payload)
        request.httpBody = jsonData
        
        _ = try? await URLSession.shared.data(for: request)
    }
    
    private func getDeviceIdentifier() -> String {
        let identifier = UIDevice.current.identifierForVendor!.uuidString
        print(identifier)
        return identifier
    }
}


struct UserUpdatePayload: Codable {
    var deviceIdentifier: String
    var deviceToken: String?
    var name: String?
    var gameId: String?
}
