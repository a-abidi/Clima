//
//  WeatherManager.swift
//  Clima
//
//  Created by Ali on 05/09/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a8f5cbb0c5bc0f0c51236bb5a6497ab8&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            
            // Create a URL session, with a default configuration, to do the networking
            let session = URLSession(configuration: .default)
            
            // completion handler is a function,
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8 )
                    print(dataString)
                }
            }
            
            // Newly initiliazed tasks begin in a suspended state, so this means start pretty much
            task.resume()
        }
    }
}
