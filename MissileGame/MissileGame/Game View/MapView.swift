//
//  MapView.swift
//  MissileGame
//
//  Created by Aidan Maguire on 11/2/24.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State var gameManager = GameManager()
    @State private var pinLocation: CLLocationCoordinate2D? = nil
    @Environment(\.colorScheme) var colorScheme
    @Namespace var mapScope
    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                MapReader { reader in
                    Map(initialPosition: MapCameraPosition.userLocation(fallback: .automatic), interactionModes: [.all], scope: mapScope)
                    {
                        UserAnnotation()
                        if let pinLocation = pinLocation {
                            if (gameManager.gameState == .planning) {
                                MapCircle(center: pinLocation, radius: Constants.MISSILE_RADIUS)
                            }
                        }
                        if let missileLocation = gameManager.myMissileLocation {
                            MapCircle(center: missileLocation, radius: Constants.MISSILE_RADIUS)
                                .foregroundStyle(.orange)
                        }
                        if let shieldLocation = gameManager.myShieldLocation {
                            MapCircle(center: shieldLocation, radius: Constants.MISSILE_RADIUS)
                                .foregroundStyle(.blue)
                        }
                        if let enemyMissileLocation = gameManager.incomingMissile?.location {
                            MapCircle(center: enemyMissileLocation, radius: Constants.MISSILE_RADIUS)
                                .foregroundStyle(.red)
                            
                        }
                    }
                    .onTapGesture(perform: { screenCoord in
                        pinLocation = reader.convert(screenCoord, from: .local) ?? CLLocationCoordinate2D(
                            latitude: LocationManager.shared.userLocation?.coordinate.latitude ?? 00,
                            longitude: LocationManager.shared.userLocation?.coordinate.longitude ?? 00)
                    })
                    .mapControls {
                        MapUserLocationButton(scope: mapScope)
                    }
                
                }
                LinearGradient(gradient: Gradient(colors: [.purple, .white, .blue]),
                               startPoint: .top,
                               endPoint: .bottom)
                .opacity(colorScheme == .light ? 0.3 : 0.15)
                    .edgesIgnoringSafeArea(.all)
                    .allowsHitTesting(false)
            }
            
            ToolbarView(gameManager: $gameManager, pinLocation: $pinLocation, missileLocation: $gameManager.myMissileLocation, shieldLocation: $gameManager.myShieldLocation)
        }
        .mapScope(mapScope)
        .navigationTitle("Magic Missiles")
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
}
