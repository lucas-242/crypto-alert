//
//  PreviewExtension.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 29/12/24.
//
import Foundation
import SwiftUI

extension PreviewProvider {

  static var dev: DeveloperPreview {
    return DeveloperPreview.instance
  }
}

class DeveloperPreview {

  static let instance: DeveloperPreview = DeveloperPreview()

  private init() {}

  let homeViewModel = HomeViewModel()

  let coin = CoinModel(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    currentPrice: 58908,
    marketCap: 1_100_013_258_170,
    marketCapRank: 1,
    fullyDilutedValuation: 1_235_028_318_246,
    totalVolume: 69_075_964_521,
    high24H: 59504,
    low24H: 57672,
    priceChange24H: 808.94,
    priceChangePercentage24H: 1.39234,
    marketCapChange24H: 13_240_944_103,
    marketCapChangePercentage24H: 1.21837,
    circulatingSupply: 18_704_250,
    totalSupply: 21_000_000,
    maxSupply: 21_000_000,
    ath: 64805,
    athChangePercentage: -9.24909,
    athDate: "2021-04-14T11:54:46.763Z",
    atl: 67.81,
    atlChangePercentage: 86630.1867,
    atlDate: "2013-07-06T00:00:00.000Z",
    lastUpdated: "2021-05-09T04:06:09.766Z",
    sparklineIn7D: SparklineIn7D(
      price: [
        57812.96915967891,
        57504.33531773738,
      ]
    ),
    priceChangePercentage24HInCurrency: 1.3923423473152687,
    currentHoldings: 1.5
  )

  let stat1 = StatisticModel(title: "Market Cap", value: "$12.58Bn", percentage: 24.12)
  let stat2 = StatisticModel(title: "Total Volume", value: "$1.45Tr")
  let stat3 = StatisticModel(title: "Portfolio Preview", value: "$54.3k", percentage: -2.13)
}
