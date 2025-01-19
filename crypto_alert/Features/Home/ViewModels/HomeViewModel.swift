//
//  HomeViewModel.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 29/12/24.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
  @Published var statistics: [StatisticModel] = []
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []

  @Published var searchText: String = ""

  private let coinService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()

  init() {
    addSubscribers()
  }

  private func addSubscribers() {
    getCoins()
    getMarketData()
    searchCoins()
  }

  private func getMarketData() {
    coinService.$marketData
      .map(mapMarketData)
      .sink { [weak self] (response) in
        self?.statistics = response
      }
      .store(in: &cancellables)
  }

  private func mapMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
    var stats: [StatisticModel] = []

    guard let data = marketDataModel else {
      return stats
    }

    let marketCap = StatisticModel(
      title: "Market Cap", value: data.marketCap,
      percentage: data.marketCapChangePercentage24HUsd
    )
    let volume = StatisticModel(title: "24h Volume", value: data.volume)
    let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
    let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentage: 0)

    stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
    return stats
  }

  private func getCoins() {
    coinService.$coins
      .sink { [weak self] (returnedCoins) in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }

  private func searchCoins() {
    $searchText
      .combineLatest(coinService.$coins)
      .debounce(for: .seconds(0.6), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] (returnedCoins) in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }

  private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else { return coins }

    let lowercasedText = text.lowercased()

    return coins.filter { coin -> Bool in
      return coin.name.lowercased().contains(lowercasedText)
        || coin.symbol.lowercased().contains(lowercasedText)
        || coin.id.lowercased().contains(lowercasedText)
    }
  }

}
