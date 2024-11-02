//
//  MapView.swift
//  MissileGame
//
//  Created by Aidan Maguire on 11/2/24.
//

import MapKit
import SwiftUI

struct MapDisplay: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
        
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .mutedStandard
        mapView.delegate = context.coordinator
        return mapView
    }
        
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
    }
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
        
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapDisplay
            
        init(_ parent: MapDisplay) {
            self.parent = parent
        }
            
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.region = mapView.region
        }
    }
}

struct MapView: View {
    @State var region = MKCoordinateRegion(
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
        var userLocation = LocationManager.shared.userLocation
        MapDisplay(region: $region)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.purple, .white, .blue]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .allowsHitTesting(false)
            )
    }
}

#Preview {
    MapView()
}
