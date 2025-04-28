//
//  WeatherService.swift
//  Closet Companion
//
//  Created by Ian Bailey on 2/18/25.
//

import Foundation
import CoreLocation
import Combine

class WeatherService: ObservableObject {
    // MARK: - Properties
    @Published var currentWeather: WeatherData = .defaultWeather
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiKey = "YOUR_API_KEY" // Replace with your actual API key
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Public Methods
    
    /// Fetch weather for a specific location by city name
    func fetchWeather(for city: String) {
        isLoading = true
        errorMessage = nil
        
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.errorMessage = "Invalid city name"
            self.isLoading = false
            return
        }
        
        let urlString = "\(baseURL)?q=\(encodedCity)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }
        
        fetchWeatherData(from: url)
    }
    
    /// Fetch weather for a specific location by coordinates
    func fetchWeather(latitude: Double, longitude: Double) {
        isLoading = true
        errorMessage = nil
        
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }
        
        fetchWeatherData(from: url)
    }
    
    /// Fetch weather for the user's current location
    func fetchWeatherForCurrentLocation(location: CLLocation) {
        fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    // MARK: - Private Methods
    
    private func fetchWeatherData(from url: URL) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .tryMap { data -> WeatherData in
                // Try to decode the data
                let decoder = JSONDecoder()
                
                // Parse OpenWeatherMap JSON response
                let response = try decoder.decode(OpenWeatherResponse.self, from: data)
                
                // Convert to our WeatherData model
                return WeatherData(
                    temperature: response.main.temp,
                    condition: response.weather.first?.main ?? "Unknown",
                    humidity: response.main.humidity,
                    windSpeed: response.wind.speed,
                    location: response.name,
                    timestamp: Date()
                )
            }
            .sink { completion in
                self.isLoading = false
                
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                }
            } receiveValue: { weatherData in
                self.currentWeather = weatherData
                self.errorMessage = nil
            }
            .store(in: &cancellables)
    }
}

// MARK: - API Response Structures

// These structures match the OpenWeatherMap API response format
private struct OpenWeatherResponse: Codable {
    let weather: [WeatherInfo]
    let main: MainInfo
    let wind: WindInfo
    let name: String
}

private struct WeatherInfo: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

private struct MainInfo: Codable {
    let temp: Double
    let humidity: Int
}

private struct WindInfo: Codable {
    let speed: Double
}

