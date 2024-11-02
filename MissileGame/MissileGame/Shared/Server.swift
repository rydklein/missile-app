//
//  Server.swift
//  MissileGame
//
//  Created by Ryder Klein on 11/2/24.
//

struct UserUpdatePayload: Codable {
    var deviceIdentifier: String
    var deviceToken: String?
    var userName: String?
}
