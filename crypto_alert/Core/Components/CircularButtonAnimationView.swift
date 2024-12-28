//
//  CircularButtonAnimationView.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 28/12/24.
//

import SwiftUI

struct CircularButtonAnimationView: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 3)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animating(animate ? .easeOut(duration: 1.0) : nil)
    }
}

#Preview {
    CircularButtonAnimationView(animate: .constant(false))
}
