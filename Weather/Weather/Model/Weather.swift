//
//  Image.swift
//  ImageDownloder
//
//  Created by Saurav Satpathy on 11/7/19.
//  Copyright © 2019 bitMountn. All rights reserved.
//

import Foundation

// MARK: - Weather
class WeatherInfo: Codable {
    let weather: [WeatherElement]?
    let base: String?
    let main: Main?
    let wind: Wind?
    let dt: Int?
    let timezone, id: Int?
    let name: String?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Float?
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let message: Double?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed, deg: Double?
}
