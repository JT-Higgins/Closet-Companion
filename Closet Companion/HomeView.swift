import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Weather & Date Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today's Weather")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.8))
                    
                    HStack {
                        Image(systemName: "cloud.sun.fill") // Weather icon
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

                // Featured Outfit Recommendation
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

                // Wardrobe Preview
                VStack(alignment: .leading) {
                    Text("Your Wardrobe")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.9))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            WardrobeItemView(icon: "tshirt.fill", label: "Shirt")
                            WardrobeItemView(icon: "pants", label: "Jeans")
                            WardrobeItemView(icon: "shoe.fill", label: "Sneakers")
                            WardrobeItemView(icon: "scarf", label: "Scarf")
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Bottom Navigation Bar
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
            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.4)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        }
    }
}

// Wardrobe Item UI
struct WardrobeItemView: View {
    var icon: String
    var label: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.3)))
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

// Bottom Nav Bar Item
struct NavBarItem: View {
    var icon: String
    var label: String
    var isSelected: Bool

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? .yellow : .white.opacity(0.6))
            Text(label)
                .font(.caption)
                .foregroundColor(isSelected ? .yellow : .white.opacity(0.6))
        }
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
