//
//  CloseButton.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 20/01/25.
//

import SwiftUI

struct PortfolioView: View {

  @EnvironmentObject private var viewModel: HomeViewModel
  @State private var selectedCoin: CoinModel? = nil

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          SearchBarView(searchText: $viewModel.searchText)
          coinList

          if selectedCoin != nil {
            VStack(spacing: 20) {
              HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWithDecimals() ?? "")
              }
              Divider()
              HStack {
                Text("Amount in your portfolio:")
                Spacer()
              }
            }
          }
        }
        .navigationTitle("Edit Portfolio")
        .toolbar(content: {
          ToolbarItem(placement: .navigationBarLeading) {
            CloseButton()
          }
        })
      }
    }
  }
}

struct PortfolioView_Previews: PreviewProvider {
  static var previews: some View {
    PortfolioView()
      .environmentObject(dev.homeViewModel)
  }
}

extension PortfolioView {
  private var coinList: some View {
    ScrollView(
      .horizontal, showsIndicators: false,
      content: {
        LazyHStack(spacing: 10) {
          ForEach(viewModel.allCoins) { coin in
            CoinLogoView(coin: coin)
              .frame(width: 75)
              .padding(4)
              .background {
                RoundedRectangle(cornerRadius: 10)
                  .stroke(
                    selectedCoin?.id == coin.id ? Color.accent : Color.clear,
                    lineWidth: 1
                  )
              }
              .onTapGesture {
                withAnimation(.easeIn) {
                  selectedCoin = coin
                }
              }
          }
        }
        .padding(.vertical, 4)
        .padding(.leading)
      })
  }
}
