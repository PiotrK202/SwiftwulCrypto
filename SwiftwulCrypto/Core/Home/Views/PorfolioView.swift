//
//  PorfolioView.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 25/02/2025.
//

import SwiftUI

struct PorfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHStack(spacing: 10) {
                            ForEach(vm.allCoins) { coins in
                                CoinLogoView(coin: coins)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

struct PorfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PorfolioView()
            .environmentObject(dev.homeVM)
    }
}


