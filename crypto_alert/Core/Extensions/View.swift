//
//  ViewAnimations.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 28/12/24.
//

import Foundation
import SwiftUI

extension View {
    func withoutAnimation() -> some View {
        self.animation(nil, value: UUID())
    }
    
    func animating(_ animation: Animation?) -> some View {
        self.animation(animation, value: UUID());
    }
}
