//
//  WeatherData.swift
//  Closet Companion
//
//  Created by Ian Bailey on 2/18/25.
//

import Foundation

struct WeatherData: Codable, Identifiable {
    let id = UUID()
    let temperature: Double
    let condition: String
    let humidity: Int
    let windSpeed: Double
    let location: String
    let timestamp: Date
    
    // Derived property for temperature unit display
    var temperatureString: String {
        return "\(Int(temperature))°C"
    }
    
    // Default weather when data isn't available
    static let defaultWeather = WeatherData(
        temperature: 0,
        condition: "Unknown",
        humidity: 0,
        windSpeed: 0,
        location: "Unknown",
        timestamp: Date()
    )
}

