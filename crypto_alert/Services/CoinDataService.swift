//
//  CoinService.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 30/12/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var coins: [CoinModel] = []
    
    private var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        let stringUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: stringUrl) else { return }
        
        coinSubscription = NetworkUtils.get(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkUtils.handleCompletion,
                  receiveValue: { [weak self] (returnedCoins) in
                    print("\(returnedCoins.count) Coins retrieved")
                    self?.coins = returnedCoins
                    self?.coinSubscription?.cancel()
            })
    }
}
