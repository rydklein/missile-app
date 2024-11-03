//
//  PrepToolbarView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//
import MapKit
import SwiftUI

struct ToolbarView: View {
    @State public var placeMode = false
    // Whatever man. You can have two sources of truth. I don't care anymore
    @Binding public var gameManager: GameManager
    @Binding public var pinLocation: CLLocationCoordinate2D?
    @Binding public var missileLocation: CLLocationCoordinate2D?
    @Binding public var shieldLocation: CLLocationCoordinate2D?
    var body: some View{
        Group {
            switch placeMode {
            case false:
                PrepToolbarView(placeMode: $placeMode, gameManager: $gameManager)
            case true:
                PlaceToolbarView(placeMode: $placeMode, pinLocation: $pinLocation, missileLocation: $missileLocation, shieldLocation: $shieldLocation)
            }
        }
        .transition(.move(edge: !placeMode ? .leading : .trailing))
    }
}

struct PrepToolbarView: View {
    @Binding var placeMode: Bool
    @Binding var gameManager: GameManager
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    placeMode = true
                }
            } label: {
                // eligibility reference
                Text("✨ Cast Spells ✨")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 23))
            }
            
            HStack {
                Button {
                    print("Lobby pressed")
                } label: {
                    Image(systemName: "person.2.circle.fill")
                        .font(.title)
                }
                
                Spacer()
                
                Group {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.purple)
                        .font(.title)
                        .opacity(gameManager.healthPoints >= 1 ? 1 : 0)
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.purple)
                        .font(.title)
                        .opacity(gameManager.healthPoints >= 2 ? 1 : 0)
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.purple)
                        .font(.title)
                        .opacity(gameManager.healthPoints >= 3 ? 1 : 0)
                }
                .padding(.vertical, 16)
                
                Spacer()
                
                NavigationLink {
                    SettingsView(gameManager: $gameManager)
                } label: {
                    Image(systemName: "gear.circle.fill")
                        .font(.title)
                }
                
                
            }
        }
        .padding(16)
        .ignoresSafeArea()
        .background(.regularMaterial)
    }
}

struct PlaceToolbarView: View {
    @Binding var placeMode: Bool
    @Binding var pinLocation: CLLocationCoordinate2D?
    @Binding public var missileLocation: CLLocationCoordinate2D?
    @Binding public var shieldLocation: CLLocationCoordinate2D?
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
                Text("Select a Spell:")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 55)
                Spacer()
            }
            HStack {
                Button {
                    print("Missile button pressed")
                    missileLocation = pinLocation
                    if let missileLocation = missileLocation {
                        ToolbarController.shared.placeMissile(missileLocation: missileLocation)
                    }
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                } label: {
                    Image(systemName: "bolt.circle")
                        .font(.system(size: 45))
                        .foregroundStyle(.primary)
                        .padding(.trailing, 20)
                }
                
                Button {
                    print("Shield button pressed")
                    shieldLocation = pinLocation
                    if let shieldLocation = shieldLocation {
                        ToolbarController.shared.placeShield(shieldLocation: shieldLocation)
                    }
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                } label: {
                    Image(systemName: "shield.righthalf.filled")
                        .font(.system(size: 45))
                        .foregroundStyle(.primary)
                        .padding(.leading, 20)
                }
            }
            .padding(.bottom, 23)
        }
        .ignoresSafeArea()
        .padding([.top, .horizontal])
        .background(.regularMaterial)
    }
}

#Preview {
    @Previewable @State var test: CLLocationCoordinate2D? = nil
    @Previewable @State var gameManager = GameManager()
    NavigationStack {
        VStack {
            Spacer()
            ToolbarView(gameManager: $gameManager, pinLocation: $test, missileLocation: $test, shieldLocation: $test)
        }
    }
}
