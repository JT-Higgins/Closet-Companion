//
//  HomeView.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

struct HomeView: View {
    
        // 0=Home, 1=Wardrobe, 2=Favorites, 3=Settings
        @Binding var selectedTab: Int
        // Pass the category name to filter in WardrobeView
        @Binding var selectedCategory: String?
    
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
                            Button {
                            selectedCategory = "Shirts"
                            selectedTab = 1
                                }
                            label: {
                            WardrobeItemView(imageType: .system(name: "tshirt.fill"), label: "Shirts")
                            }
                            Button {
                            selectedCategory = "Pants"
                            selectedTab = 1
                                }
                            label: {
                            WardrobeItemView(imageType: .asset(name: "pants_icon"), label: "Pants")
                            }
                            Button {
                            selectedCategory = "Sneakers"
                            selectedTab = 1
                                }
                            label: {
                            WardrobeItemView(imageType: .system(name: "shoe.fill"), label: "Sneakers")
                            }
                            Button {
                            selectedCategory = nil
                            selectedTab = 1
                                }
                            label: {
                            WardrobeItemView(imageType: .system(name: "plus"), label: "More")
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 20)
            .background(Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all))
        }
    }
}
