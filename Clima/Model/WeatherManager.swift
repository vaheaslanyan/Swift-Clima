//
//  WeatherManager.swift
//  Clima
//
//  Created by Vahe Aslanyan on 4/29/20.
//  Copyright © 2020 Vahe Aslanyan. All rights reserved.
//

import Foundation

// creating protocol
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    //defining a delegate var and assgning property type, which is the protocol. In this case we set our WeatherViewController as delegate (the setup is done there)
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(EV.API.weatherAPI)&units=imperial"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: String, longitude: String) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) { // with is simply an external parameter name, making it more logically readable
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give Session a Task
            let task = session.dataTask(with: url) { (data, response, error) in //in this case we used the auto-suggest to get the code with completionHandler and refactored it to a closure by selecting the code placeholder and hitting enter to automatically turn it into a trailing closure
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8) //utf8 is a standard protocol for encoding text in websited
                    if let weather = self.parseJSON(safeData) {
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            } //completionHandler is kind of like async in js, session will pass the information into handle()
            
            //4. Start Task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) //decode here takes as a first parameter a data type, which is in our WeatherData file
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil //in order to be able to return nil, the data type has to be optional
        }
    }
    
    
}
