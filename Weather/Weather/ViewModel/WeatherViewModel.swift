//
//  ImageDownloaderViewModel.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/6/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import Foundation
class WeatherViewModel {
    lazy var service = WeatherService()
    var weatherInfo: WeatherInfo?
    lazy var cache = NSCache<NSString, WeatherInfo>()

    func getWeather(_ city: String, completion: @escaping ((WeatherInfo?, Error?)->Void)) {
        if let weather = fetchFromCache(key: city as NSString) {
            completion(weather, .none)
            return
        }
        service.getWeather(city) {[unowned self] result in DispatchQueue.main.sync {
            switch result {
            case .success(let weather):
                self.weatherInfo = weather
                self.cache.setObject(weather!, forKey: city as NSString)
                completion(weather, .none)
                break
            case .failure(let error):
                completion(.none, error)
                break
            }
            }
        }
    }
    func fetchFromCache(key: NSString) -> WeatherInfo? {
        return self.cache.object(forKey: key)
    }
}
