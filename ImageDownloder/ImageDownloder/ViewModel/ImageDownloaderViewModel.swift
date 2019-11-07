//
//  ImageDownloaderViewModel.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/6/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import Foundation
class ImageDownloaderViewModel {
    lazy var service = ImageDownloaderService()
    var updated: (()->Void)?
    var images: [Image] = []
    func downloadImage(url: URL) {
        guard !images.contains(where: {$0.url.absoluteString == url.absoluteString}) else {return}
        let image = Image(imageData: Data(), progress: 0, url: url, fileName: url.lastPathComponent)
        images.append(image)
        self.updated?()
        service.downloadImage(url: url, completion: {[unowned self] result in DispatchQueue.main.sync {
            switch result {
            case .success(let data):
                self.updateProgress(1, url, data)
                break
            case .failure(let error):
                break
            }
            }
        }) {[unowned self] progress, url in
            DispatchQueue.main.sync { self.updateProgress(progress, url) }
        }
    }
    
    func updateProgress(_ progress: Float, _ url: URL, _ data: Data? = Data()) {
        if progress > 0 {
            if let row = self.images.firstIndex(where: {$0.url.absoluteString == url.absoluteString}) {
                self.images[row].progress = progress
                self.images[row].imageData = data
            }
            self.updated?()
        }
    }
}
