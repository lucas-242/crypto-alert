//
//  Double.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 29/12/24.
//

import Foundation

extension Double {
     
    ///Converts a Double into a Currency with 2 decimal places
    ///```
    ///Convert 1234.56 to $1,234.56
    ///```
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///Converts a Double into a Currency with 2-6 decimal places
    ///```
    ///Convert 1234.56 to "$1,234.56"
    ///```
    func asCurrencyWithDecimals() -> String {
        currencyFormatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    ///Converts a Double into a String representation
    ///```
    ///Convert 1.23456 to "1.23"
    ///```
    func asNumberString() -> String {
        String(format: "%.2f", self)
    }
    
    ///Converts a Double into a String representation with a paercent symbol
    ///```
    ///Convert 1.23456 to "1.23%"
    ///```
    func asPercentString() -> String {
        self.asNumberString() + "%"
    }
}
