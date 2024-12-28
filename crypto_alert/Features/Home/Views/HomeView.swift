//
//  HomeView.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 28/12/24.
//

import SwiftUI

struct HomeView: View {
        
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.background
                .ignoresSafeArea()
            
            VStack {
                homeHeader
            }
            
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
        
    }
}

extension HomeView {
    private var homeHeader : some View {
       
            HStack {
                CircularButtonView(iconName: showPortfolio ? "plus" : "info")
                    .withoutAnimation()
                    .background(
                        CircularButtonAnimationView(animate: $showPortfolio)
                    )
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
}
