//
//  StatisticModel.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 18/01/25.
//

import Foundation

struct StatisticModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentage: Double?
    
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
    
}
