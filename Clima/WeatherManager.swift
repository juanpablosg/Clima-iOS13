//
//  WeatherManager.swift
//  Clima
//
//  Created by Juan Pablo Sanchez Gonzalez on 21/10/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6b8a6f8599540cbc6def53d1a333fb33&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherData(_ cityName: String) {
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: URLString)
    }
    
    func performRequest(with URLString: String) {
        // 1. Create a URL
        guard let url = URL(string: URLString) else { return }
        print(url)
        
        // 2. Create a URL session.
        let session = URLSession.shared
        // 3. Give the session a task.
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            
            guard let safeData = data else { return }
            
            guard let weather = self.parseJSON(safeData) else {
                return
            }
            
            self.delegate?.didUpdateWeather(self, weather: weather)

            
        }
        // 4. Start the task.
        task.resume()
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
