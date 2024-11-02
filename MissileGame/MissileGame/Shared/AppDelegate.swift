//
//  Notifications.swift
//  MissileGame
//
//  Created by Ryder Klein on 11/2/24.
//
import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var notificationsRegistered = false
    var deviceToken: String? = nil
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.registerForRemoteNotifications()
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        notificationsRegistered = true
        self.deviceToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Successfully registered notifications")
        print(self.deviceToken!)
//        self.sendDeviceTokenToServer(data: deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        notificationsRegistered = false
        print("Failed to register notifications")
        print(error.localizedDescription)
        Task {
            try? await Task.sleep(for: .seconds(5))
            application.registerForRemoteNotifications()
        }
//        Handle failed
    }
}
