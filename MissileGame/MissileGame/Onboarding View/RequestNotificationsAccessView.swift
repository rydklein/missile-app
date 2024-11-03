//
//  RequestNotificationsAccessView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//

//let center = UNUserNotificationCenter.current()
//center.requestAuthorization(options: [.sound, .alert, .badge]) { _, _ in
//}
//center.getNotificationSettings(completionHandler: {notificationSettings in
//    notificationSettings.authorizationStatus
//})

import SwiftUI

struct RequestNotificationAccessView: View {
    @State public var notifAccessPermissions = false
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
            
        }
    }
}


#Preview {
    NavigationStack {
        VStack {
            RequestNotificationAccessView()
        }
    }
}
