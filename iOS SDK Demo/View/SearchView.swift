//
//  SearchView.swift
//  iOS SDK Demo
//
//  Created by Ростислав Ляшев on 03.05.2024.
//

import Foundation
import SwiftUI
import chat2desk_sdk

struct SearchView: View {
    @EnvironmentObject var viewModel: Chat2DeskViewModel
    
    @State private var messages = [Message]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List{
                ForEach(messages, id: \.self) { message in
                    Text(message.text ?? "")
                }
            }.navigationTitle("search")
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchText)  { _ in runSearch() }
    }
    
    func runSearch() {
        Task {
            messages = try await viewModel.chat2desk.findByText(query: searchText)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(Chat2DeskViewModel())
    }
}
