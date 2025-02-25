//
//  CoinimageView.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 24/02/2025.
//

import SwiftUI


struct CoinimageView: View {
    
    @StateObject var vm: CoinImageViewModel
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinimageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinimageView(coin: dev.coin)
    }
}
