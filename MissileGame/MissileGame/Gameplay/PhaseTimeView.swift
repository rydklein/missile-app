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
                } else {
                    Text("Phase: Preparation")
                }
    }
}

#Preview {
    PhaseTimeView()
}
