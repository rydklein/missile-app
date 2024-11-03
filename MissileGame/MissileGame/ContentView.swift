//
//  ContentView.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var notificationsEnabled = false
    var body: some View {
        NavigationStack {
            switch LocationManager.shared.locationAccess {
            case .unknown, .denied, .inUse:
                RequestLocationAccessView()
            case .always:
                if (!notificationsEnabled) {
                    RequestNotificationAccessView(canSeeNotifications: $notificationsEnabled)
                } else {
                    MapView()
                }
            }
        }
        .onAppear {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings(completionHandler: {notificationSettings in
                notificationsEnabled = (notificationSettings.authorizationStatus == .authorized)
            })
        }
                }
}

#Preview {
    ContentView()
}
