//
//  CoinRowView.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 29/12/24.
//

import SwiftUI

struct CoinRowView: View {
    
    @Environment(\.colorScheme) var colorScheme:ColorScheme
    
    let coin: CoinModel
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

extension CoinRowView {
   private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.textSecondary)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(colorScheme == .light ? Color.accent : Color.text)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWithDecimals())
                .fontWeight(.bold)
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWithDecimals())
                .fontWeight(.bold)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) > 0 ? Color.greenCustom
                                 : Color.redCustom)
        }.frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        
    }
}


struct CoinRowView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
