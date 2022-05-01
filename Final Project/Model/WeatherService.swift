//
//  WeatherService.swift
//  Final Project
//
//  Created by Денис Сторожик on 01.05.2022.
//

import Foundation


struct APIWeather: Encodable {
    let descriprion: String
    let iconName: String
    
    enum IconMainKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}

struct APIMain: Decodable {
    let temp: Double
}

struct APIResponse {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}
