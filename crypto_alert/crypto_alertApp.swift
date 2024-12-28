//
//  crypto_alertApp.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 28/12/24.
//

import SwiftUI

@main
struct crypto_alertApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
