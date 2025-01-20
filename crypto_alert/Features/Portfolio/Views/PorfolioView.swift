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
  @State private var quantityText: String = ""
  @State private var showCheckmark: Bool = false

  var body: some View {
    ZStack {
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            SearchBarView(searchText: $viewModel.searchText)
            coinList

            if selectedCoin != nil {
              inputSection
            }
          }
          .navigationTitle("Edit Portfolio")
          .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
              CloseButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
              trailingButton
            }
          })
        }
      }
    }
    .background(Color.background)
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
        .frame(height: 120)
        .padding(.leading)
      })
  }

  private var inputSection: some View {

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
        TextField("Ex: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }
      Divider()
      HStack {
        Text("Current Value:")
        Spacer()
        Text(getCurrentValue().asNumberString())
      }
    }

  }

  private func getCurrentValue() -> Double {
    if let quantity = Double(quantityText) {
      return quantity * (selectedCoin?.currentPrice ?? 0)
    }

    return 0
  }

  private var trailingButton: some View {
    HStack(spacing: 10) {
      Image(systemName: "checkmark")
        .opacity(showCheckmark ? 1 : 0)

      Button(
        action: {
          savePressed()
        },
        label: {
          Text("Save".uppercased())
        }
      )
      .opacity(
        (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText))
          ? 1 : 0
      )
    }
    .font(.headline)
  }

  private func savePressed() {
    guard let coin = selectedCoin else { return }

    withAnimation(.easeIn) {
      showCheckmark = true
      cleanInputs()
    }

    UIApplication.shared.closeKeyboard()

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      withAnimation(.easeOut) {
        showCheckmark = false
      }
    }
  }

  private func cleanInputs() {
    selectedCoin = nil
    viewModel.searchText = ""
    quantityText = ""
  }
}
