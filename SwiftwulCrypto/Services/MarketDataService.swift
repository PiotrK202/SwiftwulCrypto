//
//  MarketDataService.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 24/02/2025.
//

import Foundation
import Combine

// geting all logic for market data

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubsciption: AnyCancellable?
    
    init() {
        getData()
    }
    
     func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else { return }
         
         let jsonDecoder = JSONDecoder()
         jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        marketDataSubsciption = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: jsonDecoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubsciption?.cancel()
            })
        }
    }
