//
//  WeatherManager.swift
//  Clima
//
//  Created by Ali on 05/09/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a8f5cbb0c5bc0f0c51236bb5a6497ab8&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            // Create a URL session, with a default configuration, to do the networking
            let session = URLSession(configuration: .default)
            
            // completion handler is a function,
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            
            // Newly initiliazed tasks begin in a suspended state, so this means start pretty much
            task.resume()
        }
    }
    
    // Parameter type is Data since that is the format of what we get back from our session.dataTask
    func parseJSON (_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionInt: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
