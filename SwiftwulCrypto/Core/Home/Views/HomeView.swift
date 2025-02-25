//
//  HomeView.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 20/02/2025.
//

import SwiftUI

struct HomeView: View {
    
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio = false    // animate right
    @State private var showPortfolioView: Bool = false    // new sheet
    
    var body: some View {
        ZStack {
        //background layer
        Color.theme.background
            .ignoresSafeArea()
            .sheet(isPresented: $showPortfolioView) {
                PorfolioView()
                    .environmentObject(vm)
            }
            
            
        // content layer
            VStack {
                headerSettings
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                colummTitles
                
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .padding()
                
                if !showPortfolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfoloCoinList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        HomeView()
            .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var headerSettings: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .onTapGesture {
                    showPortfolioView.toggle()
                }
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
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
            .listStyle(.plain)
        }
    
    private var portfoloCoinList: some View {
            List {
                ForEach(vm.portfolioCoins) { coin in
                    CoinRowView(coin: coin, showHoldingColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    }
                }
                .listStyle(.plain)
        }
    
    private var colummTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
    }
    
    }

