//
//  RequestNotificationsAccessView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//

import SwiftUI

struct RequestNotificationAccessView: View {
    @Binding public var canSeeNotifications: Bool
    var body: some View {
        Image(systemName: "exclamationmark.bubble.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.blue)
        
        Text("To keep you protected, we need your permission to notify you of incoming magic missiles.")
            .multilineTextAlignment(.center)
            .padding()
        
        Button("Grant permission") {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.sound, .alert, .badge]) { isEnabled, _ in
                canSeeNotifications = isEnabled
            }
        }
    }
}


#Preview {
    @Previewable @State var test = false
    NavigationStack {
        VStack {
            RequestNotificationAccessView(canSeeNotifications: $test)
        }
    }
}
