//
//  SwiftwulCryptoApp.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 20/02/2025.
//

import SwiftUI

@main
struct SwiftwulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
