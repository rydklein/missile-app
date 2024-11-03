//
//  PrepToolbarView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//
import SwiftUI
import MapKit

struct ToolbarView: View {
    @State public var placeMode = false
    @Binding public var pinLocation: CLLocationCoordinate2D
    @Binding public var missileLocation: CLLocationCoordinate2D
    @Binding public var shieldLocation: CLLocationCoordinate2D
    var body: some View{
        Group {
            switch placeMode{
            case false:
                PrepToolbarView(placeMode: $placeMode)
            case true:
                PlaceToolbarView(placeMode: $placeMode, pinLocation: $pinLocation, missileLocation: $missileLocation, shieldLocation: $shieldLocation)
            }
        }
        .transition(.move(edge: !placeMode ? .leading : .trailing))
    }
}

struct PrepToolbarView: View {
    @Binding var placeMode: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    placeMode = true
                }
            } label: {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 90, height: 90)
//                    .cornerRadius(20)
//                    .overlay(alignment: .center) {
//                        Text("Prepare")
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.white)
//                    }
                Text("Prepare")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 35)
                    .background(.blue, in: .rect(cornerRadius: 20))
            }
            .padding()
            Spacer()

            // Will have to be adjusted for player lives
            ForEach(0 ..< 3) { _ in
                Image(systemName: "heart.fill")
                    .foregroundStyle(.purple)
                    .font(.title)
            }
            Spacer()
            Spacer()
            VStack {
                Button {
                    print("Lobby pressed")
                } label: {
                    Image(systemName: "person.3.fill")
                        .font(.title2)
                }
                .padding(.vertical, 10)

                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                }
                .padding(.vertical, 10)
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(.regularMaterial)
    }
}

struct PlaceToolbarView: View {
    @Binding var placeMode: Bool
    @Binding var pinLocation: CLLocationCoordinate2D
    @Binding public var missileLocation: CLLocationCoordinate2D
    @Binding public var shieldLocation: CLLocationCoordinate2D
    var body: some View {

        VStack {
            HStack {
                Button {
                    withAnimation {
                        placeMode = false
                    }
                } label: {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                    
                }
                Spacer()
                Text("Cast your spell")
                    .padding(.leading, 10)
                Spacer()
                Spacer()
            }
            HStack {
                Spacer()
                Button {
                    print("Missile button pressed")
                    missileLocation = pinLocation
                } label: {
                    Image(systemName: "bolt.horizontal.fill")
                        .font(.title)
                        .foregroundStyle(.primary)
                }
                Spacer()
                Button {
                    print("Shield button pressed")
                    shieldLocation = pinLocation
                } label: {
                    Image(systemName: "bolt.shield")
                        .font(.title)
                        .foregroundStyle(.primary)
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
        .padding([.top, .horizontal])
        .padding(.bottom, 12)
        .background(.regularMaterial)
    }
}

//#Preview {
//    NavigationStack {
//        VStack {
//            Spacer()
//            ToolbarView(pinLocation: LocationManager.shared.userLocation?.coordinate)
//        }
//    }
//}
