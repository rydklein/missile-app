//
//  DangerNotificationView.swift
//  MissileGame
//
//  Created by Ben Chesser on 11/2/24.
//

import SwiftUI

struct DangerNotificationView: View {
    @State private var timeRemaining: Double = 60.0
    
    var body: some View {
        VStack {
            Text("You're in danger! Exit the blast radius!")
                .font(.title3)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.red, in: RoundedRectangle(cornerRadius: 23))
            
            Text("Time until impact:")
                .padding(.top, 10)
                .font(.body)
                .foregroundColor(.secondary)
            
            Text(timeFormatted(timeRemaining))
                .font(.largeTitle)
                .fontWeight(.semibold)
                .monospacedDigit()
                .foregroundColor(.primary)
                .onAppear {
                    startTimer()
                }
        }
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
    
    private func timeFormatted(_ totalSeconds: Double) -> String {
        let minutes = Int(totalSeconds) / 60 // Not used rn but keeping in case we want more time
        let seconds = Int(totalSeconds) % 60
        let milliseconds = Int((totalSeconds - Double(Int(totalSeconds))) * 100)
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
    
    public func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 0.01
            } else {
                timeRemaining = 0
                timer.invalidate()
            }
        }
    }
}

#Preview {
    DangerNotificationView()
}
