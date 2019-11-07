//
//  ImageDownloaderService.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/7/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import Foundation
import UIKit
class WeatherService {
    func getWeather(_ city: String, _ completion: @escaping ((Result<WeatherInfo?, Error>)->Void)) {
        let endPoint = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=7e0d68fb96c5afc5aaa6a19f3671f165"
        let url = URL(string: endPoint)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {return completion(Result.failure(error!))}
            do{
                let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
                completion(Result.success(weatherInfo))
            }catch{
                completion(Result.failure(error))
            }
        }
        task.resume()
    }
}
    
