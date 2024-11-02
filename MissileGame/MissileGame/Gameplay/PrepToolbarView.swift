//
//  PrepToolbarView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//
import SwiftUI
struct PrepToolbarView: View {
    var body: some View {
        HStack {
            Spacer()
            Button {
                print("Prep button pressed")
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
                
                Button {
                    print("Settings pressed")
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundStyle(.primary)
                }
                .padding(.vertical, 10)
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(.regularMaterial)
    }
}
#Preview {
    VStack {
        Spacer()
        PrepToolbarView()
    }
    .ignoresSafeArea()
}
