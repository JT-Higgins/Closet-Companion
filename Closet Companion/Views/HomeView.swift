//
//  HomeView.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                WeatherView()
                
                OutfitPreviewCard()
                
                VStack(alignment: .leading) {
                    Text("Your Wardrobe")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.9))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            WardrobeItemView(imageType: .system(name: "tshirt.fill"), label: "Shirts")
                            WardrobeItemView(imageType: .asset(name: "pants_icon"), label: "Pants")
                            WardrobeItemView(imageType: .system(name: "shoe.fill"), label: "Sneakers")
                            WardrobeItemView(imageType: .system(name: "plus"), label: "More")
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)

                Spacer()

                HStack {
                    NavBarItem(icon: "house.fill", label: "Home", isSelected: true)
                    NavBarItem(icon: "hanger", label: "Wardrobe", isSelected: false)
                    NavBarItem(icon: "star.fill", label: "Favorites", isSelected: false)
                    NavBarItem(icon: "gearshape.fill", label: "Settings", isSelected: false)
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
            }
            .padding(.top, 20)
            .background(Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all))
        }
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
