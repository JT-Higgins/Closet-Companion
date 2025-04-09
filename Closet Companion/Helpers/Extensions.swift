//
//  Extensions.swift
//  Closet Companion
//
//  Created by Ian on 2/18/25.
//

import Foundation
import SwiftUI
import CoreLocation

// MARK: - CLLocationManager extensions for easier usage
extension CLLocationManager {
    func requestLocationPermission() {
        self.requestWhenInUseAuthorization()
    }
}

// MARK: - View extensions for common modifiers
extension View {
    func weatherCardStyle() -> some View {
        self
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 2)
    }
}
