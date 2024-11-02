//
//  PrepToolbarView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//
import SwiftUI

struct ToolbarView: View{
    @State public var placeMode = false
    var body: some View{
        switch placeMode{
        case false:
            PrepToolbarView(placeMode: $placeMode)
        case true:
            PlaceToolbarView(placeMode: $placeMode)
        }
    }
}

struct PrepToolbarView: View {
    @Binding var placeMode: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                placeMode = true
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
                    .background(LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ), in: .rect(cornerRadius: 20))
            }
            .padding()
            Spacer()
            
            // Will have to be adjusted for player lives
            ForEach(0 ..< 3) { _ in
                Image(systemName: "heart.fill")
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [.purple, .blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
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
    var body: some View {
        VStack{
            Button{
                placeMode = false
            } label: {
                HStack{
                    Image(systemName: "chevron.backward")
                    Text("Cast your spell")
                }
            }
            HStack{
                Spacer()
                Button{
                    print("Missile button pressed")
                } label: {
                    Image(systemName: "bolt.horizontal.fill")
                        .font(.title)
                        .foregroundStyle(.primary)
                }.padding()
                Spacer()
                Button{
                    print("Shield button pressed")
                } label: {
                    Image(systemName: "shield.checkered")
                        .font(.title)
                        .foregroundStyle(.primary)
                }.padding()
                Spacer()
            }
            
        }.ignoresSafeArea()
            .padding()
        .background(.regularMaterial)
    }
}

#Preview {
    NavigationStack {
        VStack {
            Spacer()
            ToolbarView()
        }
    }
}
