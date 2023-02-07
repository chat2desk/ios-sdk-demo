//
// Created by Rostislav Lyashev  on 19.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct MessageInput: View {
    @Binding var showAttachmentModal:Bool
    @Binding var attachment: AttachmentMeta?
    
    @State var text: String = ""
    @EnvironmentObject var viewModel: Chat2DeskViewModel
    @State var sending = false
    
    func handleAttachmentButton() {
        showAttachmentModal.toggle()
    }
    
    func sendMessageWithAttachment(_ attachment: AttachmentMeta) -> Void {
        sending = true
        Task {
            let attachedFile = attachment.toDomain()
            try await viewModel.chat2desk.sendMessage(msg: text, attachedFile: attachedFile!)
            text = ""
            self.attachment = nil
            sending = false
        }
    }
    
    func sendMessage() -> Void {
        sending = true
        Task {
            try await viewModel.chat2desk.sendMessage(msg: text)
            text = ""
            sending = false
        }
    }
    
    func handleSendMessage() -> Void {
        if let attachment = self.attachment {
            sendMessageWithAttachment( attachment)
        } else {
            sendMessage()
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if attachment != nil {
                AttachmentPreview(attachment: $attachment)
            }
            HStack(alignment: .bottom, spacing: 15) {
                Button(action: handleAttachmentButton) {
                    Image(systemName: "paperclip")
                }
                
                TextField("send_mesage", text: $text)
                
                Button(action: handleSendMessage) {
                    Image(systemName: "paperplane.fill")
                }.disabled(sending || (text.isEmpty && attachment == nil))
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 16)
            .background(Color.white, ignoresSafeAreaEdges: [])
        }
        
    }
}

struct MessageInput_Previews: PreviewProvider {
    static var previews: some View {
        MessageInput(showAttachmentModal: .constant(false), attachment: .constant(nil))
    }
}
