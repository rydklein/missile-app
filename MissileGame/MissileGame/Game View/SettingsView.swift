//
//  SettingsView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var gameManager: GameManager
    @State private var playerName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Current Game State:")
                Button(action: {
                    gameManager.gameState = gameManager.gameState == .action ? .planning : .action
                }) {
                    Text(gameManager.gameState.rawValue)
                }
            }
            if let location = LocationManager.shared.userLocation?.coordinate {
                Button(action: {
                    gameManager.incomingMissile = IncomingMissile(location: location, arrivalTime: .init(timeIntervalSinceNow: 60)
                    )}) {
                        Text("Call Missile")
                    }
            }
            if gameManager.incomingMissile != nil {
                Button(action: {
                    gameManager.incomingMissile = nil
                }) {
                    Text("Kill Missile")
                }
            }
            if (gameManager.gameState == .action) {
                Button(action: {
                    gameManager.activateShield()
                }) {
                    Text("Activate Shield")
                }
            }
            Text("Health: \(gameManager.healthPoints)")
            Button("Subtract Health") {
                gameManager.healthPoints -= 1
            }
            Button("Reset Health") {
                gameManager.healthPoints = 3
            }
        }
        .navigationTitle("Dev Tools")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    @Previewable @State var gameManager = GameManager()
    NavigationStack {
        SettingsView(gameManager: $gameManager)
    }
}
