//
//  MessageListItem.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 20.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct MessageListItem: View {
    var message: Message
    var onResend: (_ message: Message) -> ()
    
    var resendButton: some View {
        Button(action: {
            onResend(message)
        }) {
            Image(systemName: "goforward")
                .foregroundColor(.white)
        }
        .frame(width: 34, height: 34)
        .background(Color.red)
        .clipShape(Circle())
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if (message.inMessage() && message.status == .notDelivered) {
                resendButton
            }
            VStack(alignment: message.inMessage() ?.trailing: .leading){
                if let attachments = message.attachments {
                    ForEach(
                        attachments.filter{ $0.contentType.starts(with: "image/")
                        },
                        id: \.id
                    ) { attachment in
                        ImageAttachment(attachment: attachment)
                    }
                    
                    ForEach(
                        attachments.filter{ !$0.contentType.starts(with: "image/")
                        },
                        id: \.id
                    ) { attachment in
                        DocumentAttachment(attachment: attachment)
                    }
                    
                }
                
                if (!(message.text?.isEmpty ?? true)) {
                    Text(message.text ?? "")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.textPrimary)
                    
                    Spacer().frame(height: 2)
                }
                
                HStack {
                    Text(
                        messageDate(
                            milliseconds:  message.date?.toEpochMilliseconds() ?? 0
                        )
                    )
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.textSecondary)
                    .padding(.top, 3)
                    
                    Image(systemName: statusIcon(message.status))
                        .foregroundColor(message.status != .notDelivered ? .mainColor : .red)
                    
                }.frame(alignment: .center)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .frame(maxWidth: 200, alignment: message.inMessage() ? .trailing : .leading)
            .background(
                message.inMessage() ? Color.inMessageBackground : Color.outMessageBackground
            )
            .cornerRadius(10)
            
        }.frame(maxWidth: .infinity, alignment: message.inMessage() ? .trailing : .leading)
    }
}

struct MessageListItem_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            List(messagesFixture, id: \.id) {message in
                MessageListItem(message: message, onResend: { message in })
                    .listRowSeparator(.hidden)
                    .buttonStyle(BorderlessButtonStyle())
                Spacer().frame(height: 20)
            }
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 20)
        .background(Color.messageListBackground)
        
    }
}


let date = Kotlinx_datetimeInstant.Companion().fromEpochMilliseconds(epochMilliseconds: 1674306339000)

let messagesFixture: [Message] = [Message(
    id: "1",
    realId: 111,
    read: .read,
    status: .delivered,
    text: "",
    type: .in,
    date: date,
    attachments: [] as [Attachment]?
),Message(
    id: "2",
    realId: 111,
    read: .read,
    status: .delivered,
    text: "text",
    type: .out,
    date: date,
    attachments: [] as [Attachment]?
),Message(
    id: "3",
    realId: 111,
    read: .read,
    status: .delivered,
    text: "text",
    type: .in,
    date: date,
    attachments: [] as [Attachment]?
),Message(
    id: "4",
    realId: 111,
    read: .read,
    status: .delivered,
    text: "text",
    type: .out,
    date: date,
    attachments: [] as [Attachment]?
),Message(
    id: "5",
    realId: 111,
    read: .read,
    status: .notDelivered,
    text: nil,
    type: .in,
    date: date,
    attachments: [
        Attachment(id: 1, fileSize: 1, contentType: "image/jpeg", link: "http://placekitten.com/200/300", originalFileName: "Kitten", status: .delivered),
        Attachment(id: 2, fileSize: 1, contentType: "image/jpeg", link: "http://placekitten.com/200/300", originalFileName: "Kitten", status: .notDelivered),
        Attachment(id: 3, fileSize: 1, contentType: "image/jpeg", link: "http://placekitten.com/300/200", originalFileName: "Kitten", status: .sending)
    ] as [Attachment]?
),Message(
    id: "6",
    realId: 111,
    read: .read,
    status: .delivered,
    text: "text",
    type: .out,
    date: date,
    attachments: [
        Attachment(id: 1, fileSize: 1, contentType: "audio/mp3", link: "http://example.com", originalFileName: "Kitten", status: .delivered),
        Attachment(id: 2, fileSize: 1, contentType: "audio/mp3", link: "http://example.com", originalFileName: "Kitten", status: .delivered),
        Attachment(id: 3, fileSize: 1, contentType: "audio/mp3", link: "http://example.com", originalFileName: "Kitten", status: .notDelivered)
    ] as [Attachment]?
),]
