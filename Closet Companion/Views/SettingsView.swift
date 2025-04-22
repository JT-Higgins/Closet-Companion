//
//  SettingsView.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var accentColor: Color = .yellow
    @State private var useCelsius: Bool = false
    @State private var autoSyncEnabled: Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.1, green: 0.1, blue: 0.1)
                    .edgesIgnoringSafeArea(.all)

                List {
                    Section(header: Text("General")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.headline)) {
                        Toggle("Enable Notifications", isOn: $notificationsEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: accentColor))
                        Toggle("Auto‑sync Wardrobe", isOn: $autoSyncEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: accentColor))
                    }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))

                    Section(header: Text("Units")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.headline)) {
                        Toggle("Use Celsius", isOn: $useCelsius)
                            .toggleStyle(SwitchToggleStyle(tint: accentColor))
                    }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))

                    Section(header: Text("Data")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.headline)) {
                        Button("Sync Now") {
                            // TODO: Sync logic
                        }
                        .foregroundColor(.white)

                        Button("Clear Cache") {
                            // TODO: Clear cache logic
                        }
                        .foregroundColor(.red)
                    }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))

                    Section(header: Text("Support")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.headline)) {
                        Button("Send Feedback") {
                            // TODO: Feedback logic
                        }
                        .foregroundColor(.white)

                        Button("Rate on App Store") {
                            // TODO: Rating logic
                        }
                        .foregroundColor(.white)
                    }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))

                    Section(header: Text("About")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.headline)) {
                        HStack {
                            Text("App Version")
                                .foregroundColor(.white)
                            Spacer()
                            Text("1.0")
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
