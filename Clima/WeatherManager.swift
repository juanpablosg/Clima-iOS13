//
//  WeatherManager.swift
//  Clima
//
//  Created by Juan Pablo Sanchez Gonzalez on 21/10/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=london&appid=6b8a6f8599540cbc6def53d1a333fb33&units=metric"
    
    func fetchWeatherData(_ cityName: String) {
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(URLString)
    }
    
    func performRequest(_ URLString: String) {
        // 1. Create a URL
        if let url = URL(string: URLString) {
            // 2. Create a URL session.
            let session = URLSession(configuration: .default)
            // 3. Give the session a task.
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            // 4. Start the task.
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let stringData = String(data: safeData, encoding: .utf8)
            print(stringData!)
        }
    }
}
