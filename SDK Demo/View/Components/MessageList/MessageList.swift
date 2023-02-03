//
// Created by Rostislav Lyashev  on 19.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct MessageList: View {
    var messages: [Message]
    @EnvironmentObject var viewModel: Chat2DeskViewModel
    
    func resendMessage(message: Message) -> Void {
        Task {
            try await viewModel.chat2desk.resendMessage(message:message)
        }
    }
    
    var body: some View {
        List(messages, id: \.id) { message in
            MessageListItem(message: message, onResend: resendMessage)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.messageListBackground)
                .scaleEffect(x: 1, y: -1, anchor: .center)
        }
        .listStyle(.plain)
        .background(Color.messageListBackground)
        .scaleEffect(x: 1, y: -1, anchor: .center)
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        MessageList(messages: messagesFixture)
    }
}
