//
//  CoinService.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 30/12/24.
//

import Combine
import Foundation

class CoinDataService {

  @Published var coins: [CoinModel] = []
  @Published var marketData: MarketDataModel? = nil

  private var coinSubscription: AnyCancellable?
  private var marketDataSubscription: AnyCancellable?

  init() {
    getMarketData()
    getCoins()
  }

  private func getCoins() {
    let stringUrl =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"

    guard let url = URL(string: stringUrl) else { return }

    coinSubscription = NetworkUtils.get(url: url)
      .decode(type: [CoinModel].self, decoder: JSONDecoder())
      .sink(
        receiveCompletion: NetworkUtils.handleCompletion,
        receiveValue: { [weak self] (returnedCoins) in
          print("\(returnedCoins.count) Coins retrieved")
          self?.coins = returnedCoins
          self?.coinSubscription?.cancel()
        })
  }

  private func getMarketData() {
    let stringUrl = "https://api.coingecko.com/api/v3/global"
    guard let url = URL(string: stringUrl) else { return }

    marketDataSubscription = NetworkUtils.get(url: url)
      .decode(type: GlobalData.self, decoder: JSONDecoder())
      .sink(
        receiveCompletion: NetworkUtils.handleCompletion,
        receiveValue: { [weak self] (returnedGlobalData) in
          self?.marketData = returnedGlobalData.data
          self?.marketDataSubscription?.cancel()
        })
  }
}
