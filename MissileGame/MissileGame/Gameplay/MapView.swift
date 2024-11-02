//
//  MapView.swift
//  MissileGame
//
//  Created by Aidan Maguire on 11/2/24.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: LocationManager.shared.userLocation?.coordinate.latitude ?? 00,
            longitude: LocationManager.shared.userLocation?.coordinate.longitude ?? 00
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2
        )
    )

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
                // .mapStyle(.mutedStandard)
            
            LinearGradient(gradient: Gradient(colors: [.purple, .white, .blue]),
                           startPoint: .top,
                           endPoint: .bottom)
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    MapView()
}
