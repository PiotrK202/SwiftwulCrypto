//
//  HomeView.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 20/02/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
        //background layer
        Color.theme.background
            .ignoresSafeArea()
        
        // content layer
            VStack {
        Text("something")
        Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .navigationBarHidden(true)
    }
}
