//
//  ContentView.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        var locationManager = LocationManager()
        if (!locationManager.hasLocationAccess){
            RequestLocationAccessView()
        }
        else{
            MapView()
        }
    }
}

#Preview {
    ContentView()
}
