//
//  PrepToolbarView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//
import MapKit
import SwiftUI

struct ToolbarView: View {
    // Whatever man. You can have two sources of truth. I don't care anymore
    @Binding public var gameManager: GameManager
    @State public var placeMode: ToolbarType = .prep
    @Binding public var pinLocation: CLLocationCoordinate2D?
    @Binding public var missileLocation: CLLocationCoordinate2D?
    @Binding public var shieldLocation: CLLocationCoordinate2D?
    var body: some View{
//        Group {
            if gameManager.incomingMissile != nil {
                DangerNotificationView(gameManager: $gameManager)
            } else {
                switch placeMode {
                case .prep:
                    PrepToolbarView(gameManager: $gameManager, placeMode: $placeMode)
                case .place:
                    PlaceToolbarView(gameManager: $gameManager, placeMode: $placeMode, pinLocation: $pinLocation, missileLocation: $missileLocation, shieldLocation: $shieldLocation)
                case .action:
                    ActionToolbarView(gameManager: $gameManager, placeMode: $placeMode, missileLocation: $missileLocation, shieldLocation: $shieldLocation)
                default:
                    EmptyView()
                }
            }
//        }
//        .transition(.move(edge: !placeMode ? .leading : .trailing))
    }
}

struct PrepToolbarView: View {
    @Binding var gameManager: GameManager
    @Binding var placeMode: ToolbarType
    var body: some View {
        VStack {
            if (gameManager.gameState == .planning) {
                Button {
                    withAnimation {
                        placeMode = .place
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
            }
            else {
                Button {
                    withAnimation {
                        placeMode = .action
                    }
                } label: {
                    // eligibility reference
                    Text("✨ Launch Magic Missile! ✨")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue, in: RoundedRectangle(cornerRadius: 23))
                }
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
    @Binding var gameManager: GameManager
    @Binding var placeMode: ToolbarType
    @Binding var pinLocation: CLLocationCoordinate2D?
    @Binding public var missileLocation: CLLocationCoordinate2D?
    @Binding public var shieldLocation: CLLocationCoordinate2D?
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        placeMode = .prep
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
                        gameManager.placeMissile(lat: missileLocation.latitude, long: missileLocation.longitude)
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
                        gameManager.placeShield(lat: shieldLocation.latitude, long: shieldLocation.longitude)
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

struct ActionToolbarView: View {
    @Binding var gameManager: GameManager
    @Binding var placeMode: ToolbarType
    @Binding public var missileLocation: CLLocationCoordinate2D?
    @Binding public var shieldLocation: CLLocationCoordinate2D?
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        placeMode = .prep
                    }
                } label: {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                }
                Spacer()
                Text("Confirm Launch?")
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
                    print("Launch button pressed")
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    gameManager.launchMissile()
                } label: {
                    Image(systemName: "bolt.circle")
                        .font(.system(size: 60))
                        .foregroundStyle(.primary)
                        .padding(.trailing, 20)
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

enum ToolbarType {
    case prep
    case place
    case danger
    case action
}
