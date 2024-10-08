//
// Created by Rostislav Lyashev on 19.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct Header: View {
    @EnvironmentObject var viewModel: Chat2DeskViewModel
    
    @State private var activateModalView = false
    
    func connect() -> Void {
        Task {
            try await viewModel.chat2desk.start()
        }
    }
    
    func disconnect() -> Void {
        Task {
            try await viewModel.chat2desk.stop()
        }
    }
    
    func flushAll() -> Void {
        Task {
            try await   viewModel.chat2desk.flushAll()
        }
    }
    
    func syncMessages() -> Void {
        Task {
            try await viewModel.chat2desk.fetchMessages(loadMore: false, clear: true)
        }
    }
    
    func read() -> Void {
        Task {
            try await viewModel.chat2desk.read()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                OperatorView(user: $viewModel.responder)
                Spacer()
                
                Menu {
                    Button(action: {
                        activateModalView.toggle()
                    }, label: {
                        Label(
                            title: { Text("search") },
                            icon: { Image(systemName: "magnifyingglass.circle") }
                        )
                    })
                    Button("flush_all", action: flushAll)
                    Button("fetch_messages", action: syncMessages)
                    Button("read", action: read)
                } label: {
                    Label("", systemImage: "ellipsis").rotationEffect(Angle(degrees: 90))
                }
            }
            
            ConnectionStatus(connectionStatus: $viewModel.connectionStatus, onConnect: connect, onDisconect: disconnect)
        }
        .padding(.horizontal, 20)
        .padding(.top, 15)
        .padding(.bottom, 10)
        .sheet(isPresented: $activateModalView) {
            SearchView()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header().environmentObject(Chat2DeskViewModel())
    }
}
