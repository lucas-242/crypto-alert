//
//  LocalFileManager.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 10/01/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolder(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        do{
            try data.write(to: url)
        } catch let error {
            print("Error saving image: \(error)")
        }
    }
    
    private func createFolder(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName)
        else { return }
        
        if FileManager.default.fileExists(atPath: url.path) { return }
        
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        } catch let error {
            print("Error creating folder: \(error)")
        }
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
       guard let folderURL = getURLForFolder(folderName: folderName)
                else { return nil }
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
                else { return nil }
        
        return url.appendingPathComponent(folderName)
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else { return  nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
}
