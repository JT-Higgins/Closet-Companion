//
//  WardrobeItemView.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

enum WardrobeImageType {
    case system(name: String)
    case asset(name: String)
}

struct WardrobeItemView: View {
    var imageType: WardrobeImageType
    var label: String

    var body: some View {
        VStack {
            imageView
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.3)))

            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
    }

    // This determines whether to use SF Symbol or Custom Asset
    private var imageView: Image {
        switch imageType {
        case .system(let name):
            return Image(systemName: name)
        case .asset(let name):
            return Image(name)
        }
    }
}

// Preview
struct WardrobeItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WardrobeItemView(imageType: .system(name: "tshirt.fill"), label: "Shirts") // SF Symbol
            WardrobeItemView(imageType: .asset(name: "pants_icon"), label: "Pants") // Custom Image
        }
    }
}

