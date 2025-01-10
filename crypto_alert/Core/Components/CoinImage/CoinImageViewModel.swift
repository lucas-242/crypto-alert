//
//  CoinImageViewModel.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 10/01/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinImageService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        coinImageService.$image
            .sink{ [weak self] (_) in self?.isLoading = false }
                  receiveValue:{ [weak self] (image) in self?.image = image}
            .store(in: &cancellables)
    }
}
