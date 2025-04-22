//
//  FavoritesView.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

struct FavoritesView: View {
    struct ClothingItem: Identifiable, Hashable {
        let id = UUID()
        let name: String
        let imageName: String
    }
    
    @Binding var selectedTab: Int
    
    @State private var favorites: [ClothingItem]
    
    init(favorites: [ClothingItem] = [],
         selectedTab: Binding<Int>) {
        _favorites = State(initialValue: favorites)
        _selectedTab = selectedTab
    }
    
    var body: some View {
        NavigationView {
            Group {
                if favorites.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.yellow.opacity(0.7))
                        Text("No favorites yet")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.headline)
                        Button(action: {
    selectedTab = 1
}) {
    Label("Browse Wardrobe", systemImage: "hanger")
        .foregroundColor(.yellow)
}
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(favorites, id: \.self) { item in
                            HStack {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.3)))
                                
                                Text(item.name)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
                        }
                        .onDelete { indexSet in
                            // TODO: Handle unfavorite logic
                            favorites.remove(atOffsets: indexSet)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                }
            }
            .navigationTitle("Favorites")
            .background(Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoritesView(
                favorites: [],
                selectedTab: .constant(2)
            )
            .previewDisplayName("Empty State")
            FavoritesView(
                favorites: [
                    FavoritesView.ClothingItem(name: "Shirt", imageName: "tshirt.fill"),
                    FavoritesView.ClothingItem(name: "Jeans", imageName: "pants_icon"),
                ],
                selectedTab: .constant(2)
            )
            .previewDisplayName("With Favorites")
        }
    }
}
