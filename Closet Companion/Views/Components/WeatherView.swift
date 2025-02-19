//
//  WeatherView.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Weather")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.8))
            
            HStack {
                Image(systemName: "cloud.sun.fill")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                
                VStack(alignment: .leading) {
                    Text("75°F | Sunny")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text("Perfect day for light layers")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.3)))
        .padding(.horizontal)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
