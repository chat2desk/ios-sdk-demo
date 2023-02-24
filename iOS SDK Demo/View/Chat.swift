//
//  Chat.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 20.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct Chat: View {
    @State private var isShowingAttachmentModal = false
    @State private var attachment: AttachmentMeta? = nil
    
    @EnvironmentObject var viewModel: Chat2DeskViewModel
    @State var errorMessage: String?
    
    func error(_ errorMessage: String) -> some View {
        VStack {
            Spacer()
            Text(errorMessage)
                .foregroundColor(.white)
                .padding(10.0)
                .background(Color.black)
                .cornerRadius(3.0)
        }
        .padding(.bottom, 10)
        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity) )
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Header()
                MessageList(messages: viewModel.messages)
                    .onTapGesture {
                        hideKeyboard()
                    }
                MessageInput(showAttachmentModal: $isShowingAttachmentModal, attachment: $attachment)
                
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            
            AttachmentModal(isShowing: $isShowingAttachmentModal, attachment: $attachment)
            
            if let errorMessage = self.errorMessage {
                error(errorMessage)
            }
        }
        .background(Color.defaultBackground)
        .onReceive(viewModel.$connectionStatus) { status in
            if (status == .connected) {
                Task{
                    try await viewModel.chat2desk.sendClientParams(
                        name: "Chat2Desk SDK Demo",
                        phone: "Test Phone",
                        fieldSet: [1 : "Field 1", 5: "Field 5"]
                    )
                    try await viewModel.chat2desk.fetchMessages()
                }
            }
        }
        .onReceive(viewModel.$error) { error in
            if let errorMessage = error?.message {
                withAnimation { self.errorMessage = errorMessage }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation { self.errorMessage = nil }
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
