//
//  UIApplication.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 24/02/2025.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
