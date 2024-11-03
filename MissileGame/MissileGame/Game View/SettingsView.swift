//
//  SettingsView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var playerName: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Player name")) {
                    TextField("Enter your name", text: $playerName)
                }
            }
            Text(playerName)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
