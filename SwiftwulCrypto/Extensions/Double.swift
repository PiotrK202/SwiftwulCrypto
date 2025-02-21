//
//  Double.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 21/02/2025.
//

import Foundation

extension Double {
    
    private var currencyFormatter2: NumberFormatter {
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
    // Convets a double into a currency as a string with 2 decimal places
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
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
    // Convets a double into string representation
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    // Convets a double into string representation with percent symbol
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
