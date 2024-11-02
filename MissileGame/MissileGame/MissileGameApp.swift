//
//  MissileGameApp.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import SwiftUI
import SwiftData

@main
struct MissileGameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    LocationManager.shared.requestLocationAccess()
                    LocationManager.shared.startFetchingCurrentLocation()
                }
        }
        .modelContainer(for: AttackLocationModel.self)
    }
}