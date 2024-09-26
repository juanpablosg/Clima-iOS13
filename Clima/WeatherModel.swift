//
//  WeatherModel.swift
//  Clima
//
//  Created by Juanpablo Sánchez G. on 01/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let temperature: Double
    let cityName: String
    
    var temperatureString: String {
        String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "snow"
        case 701...781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
        default:
            return "cloud"
            
        }
        
        
    }
}
