//
//  PorfolioView.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 25/02/2025.
//

import SwiftUI

struct PorfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quanityText = ""
    @State private var showCheckmark = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        coinInput
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    traliningToolBar
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

extension PorfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coins in
                    CoinLogoView(coin: coins)
                        .frame(width:75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coins
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin?.id == coins.id ? Color.theme.green : Color.clear ,lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }

    }
    
    private var coinInput: some View {
        VStack(spacing: 20) {
            HStack {
                Text("current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount in portfolio")
                Spacer()
                TextField("Ex: 1.4", text: $quanityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
    }
    
    private var traliningToolBar: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            Button {
                saveButtonPressed()
            } label: {
                Text("SAVE")
            }
            .opacity( selectedCoin != nil && selectedCoin?.currentHoldings != Double(quanityText) ? 1 : 0 )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }
        
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private func getCurrentValue() -> Double {
        if let quanity = Double(quanityText) {
            return quanity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
}
