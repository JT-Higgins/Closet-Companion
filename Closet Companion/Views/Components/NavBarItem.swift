//
//  NavBarItem.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

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

struct NavBarItem_Previews: PreviewProvider {
    static var previews: some View {
        NavBarItem(icon: "house.fill", label: "Home", isSelected: true)
    }
}
