//
//  OutfitPreviewCard.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

struct OutfitPreviewCard: View {
    var body: some View {
        VStack {
            Text("Your Outfit Recommendation")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.9))
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    VStack {
                        Image(systemName: "tshirt.fill") // Placeholder
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.8))
                        Text("Casual Shirt, Denim Jeans, Sneakers")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                )
        }
        .padding(.horizontal)
    }
}

struct OutfitPreviewCard_Previews: PreviewProvider {
    static var previews: some View {
        OutfitPreviewCard()
    }
}
