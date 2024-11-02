//
//  ContentView.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        switch LocationManager.shared.locationAccess {
        case .unknown, .denied, .inUse:
            RequestLocationAccessView()
        case .always:
            MapView()
        }
    }
}

#Preview {
    ContentView()
}
