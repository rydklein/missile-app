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
            latitude: 37.334900,
            longitude: -122.009020
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2
        )
    )

    var body: some View {
        ZStack {
            Map()
            Map(coordinateRegion: $region, interactionModes: [.all])
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
