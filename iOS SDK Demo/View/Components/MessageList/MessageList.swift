//
// Created by Rostislav Lyashev  on 19.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct MessageList: View {
    @EnvironmentObject var viewModel: Chat2DeskViewModel
    
    func resendMessage(message: Message) -> Void {
        Task {
            try await viewModel.chat2desk.resendMessage(message: message)
        }
    }
    
    var emptyList: some View {
        List {
            Text("empty_list")
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.messageListBackground)
        }
        .listStyle(.plain)
        .background(Color.messageListBackground)
    }
    
    var list: some View {
        List(viewModel.messages, id: \.id) { message in
            MessageListItem(message: message, onResend: resendMessage)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.messageListBackground)
                .scaleEffect(x: 1, y: -1, anchor: .center)
                .buttonStyle(BorderlessButtonStyle())
            
        }
        .listStyle(.plain)
        .background(Color.messageListBackground)
        .scaleEffect(x: 1, y: -1, anchor: .center)
    }
    
    var body: some View {
        if (viewModel.messages.count == 0) {
            emptyList
        } else {
            list
        }
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageList()
            MessageList()
        }
    }
}
