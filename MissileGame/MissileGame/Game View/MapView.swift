//
//  MapView.swift
//  MissileGame
//
//  Created by Aidan Maguire on 11/2/24.
//

import MapKit
import SwiftUI

let defaultCoord = CLLocationCoordinate2D(
    latitude: 00,
    longitude: 00)


struct MapView: View {
    private let region: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: LocationManager.shared.userLocation?.coordinate.latitude ?? 00,
            longitude: LocationManager.shared.userLocation?.coordinate.longitude ?? 00
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2
        )
    )
    )
    @State private var pinLocation = LocationManager.shared.userLocation?.coordinate ?? defaultCoord
    @State public var missileLocation = LocationManager.shared.userLocation?.coordinate ?? defaultCoord
    @State public var shieldLocation = LocationManager.shared.userLocation?.coordinate ?? defaultCoord
    @Namespace var mapScope
    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                MapReader { reader in
                    Map(initialPosition: .userLocation(fallback: region), interactionModes: [.all], scope: mapScope)
                    {
                        UserAnnotation()
                        MapCircle(center: pinLocation, radius: 200)
                        
                        if (missileLocation.longitude != 00) {
                            MapCircle(center: missileLocation, radius: 200)
                                .foregroundStyle(.red)
                        }
                        if (shieldLocation.longitude != 00) {
                            MapCircle(center: shieldLocation, radius: 200)
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
            
            ToolbarView(pinLocation: $pinLocation, missileLocation: $missileLocation, shieldLocation: $shieldLocation)
        }
        .mapScope(mapScope)
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
}
