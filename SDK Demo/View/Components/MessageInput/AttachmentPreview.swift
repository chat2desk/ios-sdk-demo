//
//  AttachmentPreview.swift
//  iosDemo
//
//  Created by Ростислав Ляшев on 23.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import Foundation
import SwiftUI
import chat2desk_sdk

struct AttachmentPreview: View {
    @Binding var attachment: AttachmentMeta?
    
    var document: some View {
        Image(systemName: "doc.text").foregroundColor(Color.mainColor)
    }
    
    var image: some View {
        AsyncImage(
            url: attachment?.contentUri
        ) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 48, height: 48)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                if (attachment?.mimeType.starts(with: "image/") ?? false) {
                    image
                } else {
                    document
                }
            }
            .frame(width: 48, height: 48)
            .background(Color.messageListBackground)
            .cornerRadius(8)
            
            Spacer()
                .frame(width: 8)
            
            VStack(alignment: .leading) {
                Text(attachment?.originalName ?? "")
                    .lineLimit(1)
                    .font(
                        .system(size: 14, weight: .medium))
                    .foregroundColor(.mainColor)
                
                Spacer()
                
                Text(formatBytes(attachment?.fileSize ?? 0))
                    .font(
                        .system(size: 14, weight: .regular))
                    .foregroundColor(.textSecondary)
                
            }
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity, maxHeight: 48, alignment: .leading)
            
            Button(action: {
                attachment = nil
            }) {
                Image(systemName: "trash.slash.fill")
                    .foregroundColor(.red)
            }
            .frame(width: 40, height: 40)
        }.padding(.all, 10).background(.white)
    }
}

struct AttachmentPreview_Preview: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading){
            ForEach(attachments, id: \.contentUri) { attachment in
                AttachmentPreview(attachment: .constant(attachment))
            }
        }
        .padding(.vertical, 10)
        .background(Color.messageListBackground)
    }
}


let attachments: [AttachmentMeta] = [
    AttachmentMeta(contentUri: URL(string:""), originalName: "test.txt", fileSize: 1000, mimeType: "text/txt"),
    AttachmentMeta(contentUri: URL(string:"http://placekitten.com/200/300"), originalName: "test.txt", fileSize: 1200, mimeType: "image/jpeg")
]
