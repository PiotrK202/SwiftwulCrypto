//
//  HomeView.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 20/02/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
        //background layer
        Color.theme.background
            .ignoresSafeArea()
        
        // content layer
            VStack {

                headerSettings
                
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

extension HomeView {
    private var headerSettings: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .animation(.none)
                .font(.headline)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
