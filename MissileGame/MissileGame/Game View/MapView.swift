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
    @Namespace var mapScope
    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                MapReader { reader in
                    Map(initialPosition: MapCameraPosition.userLocation(fallback: .automatic), interactionModes: [.all], scope: mapScope)
                    {
                        UserAnnotation()
                        if let pinLocation = pinLocation {
                            MapCircle(center: pinLocation, radius: Constants.MISSILE_RADIUS)
                        }
                        if let missileLocation = gameManager.myMissileLocation {
                            MapCircle(center: missileLocation, radius: Constants.MISSILE_RADIUS)
                                .foregroundStyle(.red)
                        }
                        if let shieldLocation = gameManager.myShieldLocation {
                            MapCircle(center: shieldLocation, radius: Constants.MISSILE_RADIUS)
                                .foregroundStyle(.blue)
                        }
                    }
                    .onTapGesture(perform: { screenCoord in
                        pinLocation = reader.convert(screenCoord, from: .local) ?? CLLocationCoordinate2D(
                            latitude: LocationManager.shared.userLocation?.coordinate.latitude ?? 00,
                            longitude: LocationManager.shared.userLocation?.coordinate.longitude ?? 00)
                        print(pinLocation)
                    })
                    .mapControls {
                        MapUserLocationButton(scope: mapScope)
                    }
                
                }
                LinearGradient(gradient: Gradient(colors: [.purple, .white, .blue]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .allowsHitTesting(false)
            }
            
            ToolbarView(pinLocation: $pinLocation, missileLocation: $gameManager.myMissileLocation, shieldLocation: $gameManager.myShieldLocation)
        }
        .mapScope(mapScope)
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
}
