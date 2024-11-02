//
//  RequestLocationAccessView.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import SwiftUI

struct RequestLocationAccessView: View {
    var body: some View {
        Image(systemName: "sparkles")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.blue)
        
        Text("To get into the magic, we need your location information")
            .multilineTextAlignment(.center)
            .frame(width: 345, height: 45)
        
        Button("Allow Access") {
            switch LocationManager.shared.locationAccess {
            case .unknown:
                LocationManager.shared.requestWhenInUseAccess()
            case .denied:
                LocationManager.shared.requestWhenInUseAccess()
            case .inUse:
                LocationManager.shared.requestAlwaysLocationAccess()
            case .always:
                MapView()
            }
        }
    }
}

#Preview {
    RequestLocationAccessView()
}


//        ZStack {
//            Image(systemName: "bolt.horizontal.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .rotationEffect(.degrees(40))
//            Image(systemName: "bolt.horizontal.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.teal)
//                .rotationEffect(.degrees(15))
//            Image(systemName: "bolt.horizontal.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .rotationEffect(.degrees(-10))
//        }
//
