//
//  WeatherView.swift
//  Closet Companion
//
//  Created by Ian on 5/1/24.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject private var weatherService = WeatherService()
    @StateObject private var locationManager = LocationManager()
    @State private var city = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Weather Search Bar
            HStack {
                TextField("Enter city name", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    if !city.isEmpty {
                        weatherService.fetchWeather(for: city)
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            // Current Location Button
            Button(action: {
                locationManager.requestLocation()
            }) {
                Label("Use Current Location", systemImage: "location.fill")
            }
            .padding(.bottom)
            
            // Weather Card
            VStack(alignment: .leading, spacing: 10) {
                Text(weatherService.currentWeather.location)
                    .font(.title)
                    .bold()
                
                HStack {
                    Text(weatherService.currentWeather.temperatureString)
                        .font(.system(size: 50))
                        .bold()
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(weatherService.currentWeather.condition)
                            .font(.title2)
                        
                        Text("Humidity: \(weatherService.currentWeather.humidity)%")
                        
                        Text("Wind: \(Int(weatherService.currentWeather.windSpeed)) km/h")
                    }
                }
            }
            .weatherCardStyle()
            .padding(.horizontal)
            
            // Loading and Error States
            if weatherService.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            if let errorMessage = weatherService.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding(.top)
        .onAppear {
            locationManager.requestLocation()
        }
        .onChange(of: locationManager.location) { newLocation in
            if let newLocation = newLocation {
                weatherService.fetchWeatherForCurrentLocation(location: newLocation)
            }
        }
    }
}

// Location Manager class to handle getting the user's location
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var locationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}

#Preview {
    WeatherView()
} 