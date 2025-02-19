//
//  HomeView.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 28/12/24.
//

import SwiftUI

struct HomeView: View {

  @EnvironmentObject private var viewModel: HomeViewModel
  @State private var showPortfolio: Bool = false
  @State private var showSheet: Bool = false

  var body: some View {
    ZStack(alignment: .top) {

      Color.background
        .ignoresSafeArea()
        .sheet(
          isPresented: $showSheet,
          content: {
            PortfolioView()
              .environmentObject(viewModel)
          })

      VStack {
        homeHeader
        HomeStatsView(showPortfolio: $showPortfolio)
        SearchBarView(searchText: $viewModel.searchText)
        coinsHeader

        if !showPortfolio {
          allCoins
        }

        if showPortfolio {
          portfolioCoins
        }
      }

      Spacer(minLength: 0)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
        .navigationBarHidden(true)
        .environmentObject(dev.homeViewModel)

    }
  }
}

extension HomeView {
  private var homeHeader: some View {

    HStack {
      CircularButtonView(iconName: showPortfolio ? "plus" : "info")
        .withoutAnimation()
        .background(
          CircularButtonAnimationView(animate: $showPortfolio)
        )
        .onTapGesture {
          if showPortfolio {
            showSheet.toggle()
          }
        }
      Spacer()
      Text(showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.text)
        .withoutAnimation()
      Spacer()
      CircularButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()) {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)

  }

  private var coinsHeader: some View {
    HStack {
      Text("Coin")
      Spacer()
      if showPortfolio {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(Color.textSecondary)
    .padding(.horizontal)
  }

  private var allCoins: some View {
    List {
      ForEach(viewModel.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingColumn: false)
          .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
          .listRowBackground(Color.background)
      }
    }
    .listStyle(PlainListStyle())
    .transition(.move(edge: .leading))
  }

  private var portfolioCoins: some View {
    List {
      ForEach(viewModel.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingColumn: true)
          .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
    .transition(.move(edge: .trailing))
  }
}
