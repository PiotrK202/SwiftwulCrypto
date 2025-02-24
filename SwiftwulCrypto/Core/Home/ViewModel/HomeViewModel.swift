//
//  HomeViewModel.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 21/02/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        }
    
    func addSubscribers() {
        
        // update all coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for:.seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text, startingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                let lowercasedText = text.lowercased()
                
                return startingCoins.filter { coin -> Bool in
                    return coin.name.lowercased().contains(lowercasedText) ||
                            coin.symbol.lowercased().contains(lowercasedText) ||
                            coin.id.lowercased().contains(lowercasedText)
                }
            }
            .sink { [weak self] returnedCoins in
                  self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .map { (marketDataModel) -> [StatisticModel] in
                var stats: [StatisticModel] = []
                
                guard let data = marketDataModel else {
                    return stats
                }
                let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            
                let volume = StatisticModel(title: "24H Volue", value: data.volume)
                
                let btcDomiace = StatisticModel(title: "BTC Dominace", value: data.btcDominance)
                
                let portfolio = StatisticModel(title: "Portfolio value", value: "$0.00", percentageChange: 0)
                
                stats.append(contentsOf: [ marketCap, volume, btcDomiace, portfolio])
                
                return stats
            }
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
        }
            .store(in: &cancellables)
    }
}
