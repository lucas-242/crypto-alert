//
//  HomeViewModel.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 29/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let coinService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        coinService.$coins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins 
            }
            .store(in: &cancellables)
    }
    
}
