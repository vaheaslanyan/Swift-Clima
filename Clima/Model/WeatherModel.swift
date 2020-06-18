//
//  WeatherModel.swift
//  Clima
//
//  Created by Vahe Aslanyan on 4/29/20.
//  Copyright © 2020 Vahe Aslanyan. All rights reserved.
//

import Foundation

struct WeatherModel {
    //stored properties
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    //computed properties
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        var conditionIconName: String
        switch conditionId {
        case 200...232:
            conditionIconName = "cloud.bolt" //"Thunderstorm"
        case 300...321:
            conditionIconName = "cloud.drizzle" //"Drizzle"
        case 500...531:
            conditionIconName = "cloud.rain" //"Rain"
        case 600...622:
            conditionIconName = "snow" //"Snow"
        case 700...781:
            conditionIconName = "sun.haze" //"Atmosphere"
        case 801...804:
            conditionIconName = "cloud" //"Clouds"
        default:
            conditionIconName = "sun.max" //"Clear"
        }
        
        return conditionIconName
    }
}
