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
            Button {
                
            } label: {
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                    Text("Get Ready")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            
            ForEach(0..<3) { i in
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }
            
            VStack {
                Button {
                    print("Lobby pressed")
                } label: {
                    Image(systemName: "person.3.fill")
                        .padding()
                }
                Button {
                    print("Settings pressed")
                } label: {
                    Image(systemName: "gearshape.fill")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    PrepToolbarView()
}
