//
//  PhaseTimeView.swift
//  MissileGame
//
//  Created by asimraja on 11/2/24.
//

import SwiftUI

struct PhaseTimeView: View {
    var body: some View {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour >= 8 && hour < 18 { // Between 8 AM and 6 PM
            Text("Phase: Action")
            Text("Time until 6 PM: \(timeUntil6PM())")
        } else {
            Text("Phase: Preparation")
            Text("Time until 8 AM: \(timeUntil8AM())")
        }
    }
}

func timeUntil6PM() -> String {
    let calendar = Calendar.current
    let now = Date()
    
    // Set target time to 6 PM today
    if let sixPM = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: now), sixPM > now {
        // Calculate the time interval until 6 PM
        let interval = sixPM.timeIntervalSince(now)
        
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        
        // Format the time remaining as HH:mm:ss
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    } else {
        // If it's already past 6 PM, return a placeholder or set for the next 6 PM
        return "00:00:00"
    }
}

func timeUntil8AM() -> String {
    let calendar = Calendar.current
    let now = Date()
    
    // Set target time to 6 PM today
    if let eightAM = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now), eightAM > now {
        // Calculate the time interval until 6 PM
        let interval = eightAM.timeIntervalSince(now)
        
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        
        // Format the time remaining as HH:mm:ss
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    } else {
        // If it's already past 8 AM, return a placeholder or set for the next 8 AM
//        if let eightAMTomorrow = calendar.date(byAdding: .day, value: 1, to: eightAM)
        return "00:00:00"
    }
}

#Preview {
    PhaseTimeView()
}
