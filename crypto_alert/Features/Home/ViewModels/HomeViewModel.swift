//
//  HomeViewModel.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 29/12/24.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
  @Published var statistics: [StatisticModel] = [
    StatisticModel(title: "Market Cap", value: "$12.58Bn", percentage: 24.12),
    StatisticModel(title: "Market Cap", value: "$12.58Bn", percentage: 24.12),
    StatisticModel(title: "Total Volume", value: "$1.45Tr"),
    StatisticModel(title: "Portfolio Preview", value: "$54.3k", percentage: -2.13),
  ]

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
    searchCoins()
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
