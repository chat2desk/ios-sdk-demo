//
//  DocumentAttachment.swift
//  iosDemo
//
//  Created by Ростислав Ляшев on 23.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct DocumentAttachment: View {
    let attachment: Attachment
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                if (attachment.status == .notDelivered) {
                    Image(systemName: statusIcon(attachment.status)).foregroundColor(attachment.status != .notDelivered ? .white : .red)
                } else {
                    Image(systemName: "doc.text").foregroundColor(Color.mainColor)
                }
            }
            .frame(width: 48, height: 48)
            .background(Color.messageListBackground)
            .cornerRadius(8)
            
            Spacer()
                .frame(width: 8)
            
            VStack(alignment: .leading) {
                Text(attachment.originalFileName ?? "")
                    .lineLimit(1)
                    .font(
                        .system(size: 14, weight: .medium))
                    .foregroundColor(.mainColor)
                
                Spacer()
                
                Text(formatBytes(attachment.fileSize))
                    .font(
                        .system(size: 14, weight: .regular))
                    .foregroundColor(.textSecondary)
                
            }
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity, maxHeight: 48, alignment: .leading)
        }.padding(.all, 10)
    }
}

struct DocumentAttachment_Preview: PreviewProvider {
    static var previews: some View {
        DocumentAttachment(attachment: Attachment.init(id: 1, fileSize: 1000, contentType: "text/txt", link: "", originalFileName: "test.txt", status: .delivered))
    }
}
