//
//  OutfitPreviewCard.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI
import UIKit


struct OutfitPreviewCard: View {
    @State private var clothes: [ClothingItem] = Self.loadItems()

    private var recommendation: [ClothingItem] {
        if clothes.isEmpty { return [] }
        return Array(clothes.shuffled().prefix(3))
    }

    var body: some View {
        VStack {
            Text("Your Outfit Recommendation")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.9))

            if recommendation.isEmpty {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .overlay(
                        VStack(spacing: 12) {
                            Image(systemName: "plus.app.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white.opacity(0.8))
                            Text("Add some clothes to get started!")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    )
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .overlay(
                        VStack(spacing: 8) {
                            HStack(spacing: 15) {
                                ForEach(recommendation) { item in
                                    if let uiImage = Self.loadImage(named: item.imageFileName) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .padding(4)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.black.opacity(0.3))
                                            )
                                    }
                                }
                            }
                            Text(recommendation.map { $0.name }.joined(separator: ", "))
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding()
                    )
            }
        }
        .padding(.horizontal)
    }

    private static func documentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    private static func dataFileURL() -> URL {
        documentsDirectory().appendingPathComponent("clothing_items.json")
    }

    static func loadItems() -> [ClothingItem] {
        let url = dataFileURL()
        guard let data = try? Data(contentsOf: url),
              let items = try? JSONDecoder().decode([ClothingItem].self, from: data) else {
            return []
        }
        return items
    }

    static func loadImage(named fileName: String) -> UIImage? {
        let url = documentsDirectory().appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }
}

struct OutfitPreviewCard_Previews: PreviewProvider {
    static var previews: some View {
        OutfitPreviewCard()
            .preferredColorScheme(.dark)
    }
}
