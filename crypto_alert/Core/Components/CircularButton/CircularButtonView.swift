//
//  CircularButtonView.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 28/12/24.
//

import SwiftUI

struct CircularButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .frame(width: 50, height: 50)
            .foregroundColor(Color.text)
            .background(
                Circle()
                    .foregroundColor(Color.background)
            )
            .shadow(
                color: Color.text.opacity(0.15),
                radius: 5, x: 0, y: 0
            )
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircularButtonView(iconName: "info")
            .previewLayout(.sizeThatFits)
    }
}
