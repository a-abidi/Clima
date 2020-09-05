//
//  WeatherData.swift
//  Clima
//
//  Created by Ali on 05/09/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// Decodable means that the weather data is a type which can decode itself from an external respresentaiton (in this case, JSON)
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Main: Codable {
    let temp: Double
    
}
