//
//  NavigationTabs.swift
//  iOS SDK Demo
//
//  Created by Ростислав Ляшев on 11.12.2023.
//

import SwiftUI

struct NavigationTabs: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationView {
                if (selectedIndex == 0) {
                    HomeView()
                }
            }
            .onTapGesture {
                selectedIndex = 0
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            
            NavigationView {
                if (selectedIndex == 1) {
                    ChatView()
                }
            }
            .onTapGesture {
                selectedIndex = 1
            }
            .tabItem {
                Label("Chat", systemImage: "message.fill")
            }
            .tag(1)
        }
        
    }
}
