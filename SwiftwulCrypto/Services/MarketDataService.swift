//
//  MarketDataService.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 24/02/2025.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubsciption: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else { return }
        
        marketDataSubsciption = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubsciption?.cancel()
            })
        }
    }
