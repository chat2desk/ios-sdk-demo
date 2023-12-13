//
//  HomeView.swift
//  iOS SDK Demo
//
//  Created by Ростислав Ляшев on 11.12.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            Text("Home View").environmentObject(self.viewModel)
        }
    }
}
