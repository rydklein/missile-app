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
        
        Text("To get into the magic, we need your location information.")
            .multilineTextAlignment(.center)
        
        Button("Allow Access") {
            print(LocationManager.shared.locationAccess)
            switch LocationManager.shared.locationAccess {
            case .unknown:
                LocationManager.shared.requestWhenInUseAccess()
                LocationManager.shared.requestAlwaysLocationAccess()
            case .denied:
                LocationManager.shared.requestWhenInUseAccess()
                LocationManager.shared.requestAlwaysLocationAccess()
            case .inUse:
                LocationManager.shared.requestAlwaysLocationAccess()
            case .always:
                break
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
