//
//  CoinImageService.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 10/01/25.
//
import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    
    init(urlString: String) {
        getCoinImage(urlString: urlString)
    }
    
    private func getCoinImage(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        
        imageSubscription = NetworkUtils.get(url: url)
            .tryMap({ (data) -> UIImage? in return UIImage(data: data)})
            .sink(receiveCompletion: NetworkUtils.handleCompletion, receiveValue: {[weak self] (result) in
                self?.image = result
                self?.imageSubscription?.cancel()
            })
    }
}
