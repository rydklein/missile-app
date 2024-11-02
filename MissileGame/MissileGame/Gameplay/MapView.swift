//
//  MapView.swift
//  MissileGame
//
//  Created by Aidan Maguire on 11/2/24.
//

import MapKit
import SwiftUI

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
    @State private var pinLocation = LocationManager.shared.userLocation?.coordinate
    @Namespace var mapScope
    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                MapReader { reader in
                    Map(initialPosition: .userLocation(fallback: region), interactionModes: [.all], scope: mapScope) {
                        UserAnnotation()
                    }
                    .onTapGesture(perform: { screenCoord in
                        pinLocation = reader.convert(screenCoord, from: .local)
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
            ToolbarView()
        }
        .mapScope(mapScope)
    }
}

#Preview {
    NavigationStack {
        MapView()
    }
}
