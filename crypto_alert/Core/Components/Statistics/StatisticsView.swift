//
//  StatisticsView.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 18/01/25.
//

import SwiftUI

struct StatisticsView: View {
  let stat: StatisticModel

  var body: some View {
      VStack(alignment: .leading, spacing: 4) {
      Text(stat.title)
        .font(.caption)
        .foregroundStyle(Color.textSecondary)

      Text("\(stat.value)")
        .font(.title2)
        .foregroundStyle(Color.accent)

      HStack(spacing: 4) {
        Image(systemName: "triangle.fill")
          .font(.caption2)
          .rotationEffect(Angle(degrees: (stat.percentage ?? 0) >= 0 ? 0 : 180))

        Text(stat.percentage?.asPercentString() ?? "")
          .font(.caption)
          .bold()
      }
      .foregroundStyle((stat.percentage ?? 0) >= 0 ? Color.greenCustom : Color.redCustom)
      .opacity(stat.percentage == nil ? 0 : 1)
    }
  }
}

struct StatisticsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StatisticsView(stat: dev.stat1)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)

      StatisticsView(stat: dev.stat2)
        .previewLayout(.sizeThatFits)

      StatisticsView(stat: dev.stat3)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)

    }
  }
}
