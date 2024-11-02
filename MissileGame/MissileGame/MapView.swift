//
//  MapView.swift
//  MissileGame
//
//  Created by Aidan Maguire on 11/2/24.
//

import SwiftUI
import MapKit

struct MapDisplay: UIViewRepresentable{
    @Binding var region: MKCoordinateRegion
        
        func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
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
                latitude: 37.334_900,
                longitude: -122.009_020
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.2,
                longitudeDelta: 0.2
            )
        )
    var body: some View {
        var LocationManager = LocationManager()
        var userLocation = LocationManager.userLocation
        MapDisplay(region: $region)
                    .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView()
}
