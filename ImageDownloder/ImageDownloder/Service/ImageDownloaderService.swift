//
//  ImageDownloaderService.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/7/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import Foundation
import UIKit
class ImageDownloaderService {
    lazy var queue = OperationQueue()
    func downloadImage(url: URL, completion: @escaping ((Result<Data?, Error>)->Void), progression: @escaping ((Float, URL)->Void)) {
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(2))
        let task = URLSession.shared.downloadTask(with: url) { (localUrl, response, error) in
            timer.cancel()
            guard let response = response as? HTTPURLResponse,
                                 response.statusCode == 200,
                                 let localUrl = localUrl,
                                 error == nil,
                                 let data = try? Data.init(contentsOf: localUrl)else {return}
            completion(Result.success(data))
        }
        timer.setEventHandler {progression(Float(task.progress.fractionCompleted), url)}
        task.resume()
        timer.resume()
    }
}
    
