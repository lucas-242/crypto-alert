//
//  UIApplication.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 10/01/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
