//
//  ContentView.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var selectedCategory: String? = nil

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(
                selectedTab: $selectedTab,
                selectedCategory: $selectedCategory
            )
            .tag(0)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            WardrobeView(
                selectedCategory: selectedCategory
            )
            .tag(1)
            .tabItem {
                Image(systemName: "hanger")
                Text("Wardrobe")
            }

            FavoritesView(selectedTab: $selectedTab)
                .tag(2)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }

            SettingsView()
                .tag(3)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .tint(.yellow)
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
