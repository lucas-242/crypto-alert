import SwiftUI

struct HomeStatsView: View {
  @EnvironmentObject private var viewModel: HomeViewModel
  @Binding var showPortfolio: Bool

  var body: some View {
    HStack {
      ForEach(viewModel.statistics) { stat in
        StatisticsView(stat: stat)
          .frame(width: UIScreen.main.bounds.width / 3)
      }
    }
    .frame(
      width: UIScreen.main.bounds.width,
      alignment: showPortfolio ? .trailing : .leading
    )
  }
}

struct HomeStatsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeStatsView(showPortfolio: .constant(false))
      .environmentObject(dev.homeViewModel)
  }
}
