//
//  Double.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 21/02/2025.
//

import Foundation

extension Double {
    // Convets a double into a currency with 2-6 decimal places
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    // Convets a double into a currency as a string with 2-6 decimal places
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
}
