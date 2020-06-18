//
//  File.swift
//  Clima
//
//  Created by Vahe Aslanyan on 4/29/20.
//  Copyright © 2020 Vahe Aslanyan. All rights reserved.
//

import Foundation

//this file is to help with JSON parsing in WeatherManager

struct WeatherData: Codable { //typealias Codable = Decodable & Encodable
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
