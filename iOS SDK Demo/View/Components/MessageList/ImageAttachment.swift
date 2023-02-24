//
//  ImageAttachment.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 23.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct ImageAttachment: View {
    let attachment: Attachment
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: attachment.link)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            if (attachment.status != .delivered) {
                Group {
                    Image(systemName: statusIcon(attachment.status)).foregroundColor(attachment.status != .notDelivered ? .white : .red)
                }
                .frame(width: 50, height: 50)
                .background(Color.mainSecondary)
                .cornerRadius(25)
            }
        }
    }
}

struct ImageAttachment_Preview: PreviewProvider {
    static var previews: some View {
        ImageAttachment(attachment: Attachment.init(id: 1, fileSize: 1000, contentType: "image/jpeg", link: "http://placekitten.com/200/300", originalFileName: "test.jpg", status: .sending))
    }
}
