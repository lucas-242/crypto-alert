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
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage(coin: coin)
    }
    
    private func getCoinImage(coin: CoinModel) {
        if let savedImage = fileManager.getImage(imageName:imageName, folderName: folderName) {
            image = savedImage
            print("Image from cache")
        } else {
            downloadCoinImage(urlString: coin.image)
            print("Image from Network")
        }
    }
    
    private func downloadCoinImage(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        
        imageSubscription = NetworkUtils.get(url: url)
            .tryMap({ (data) -> UIImage? in return UIImage(data: data)})
            .sink(receiveCompletion: NetworkUtils.handleCompletion, receiveValue: {[weak self] (result) in
                guard let self = self, let downloadImage = result else { return }
                self.image = downloadImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadImage, imageName: imageName, folderName: folderName)
            })
    }
}
