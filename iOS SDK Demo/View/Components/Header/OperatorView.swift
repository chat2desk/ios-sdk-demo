//
//  Operator.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 19.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct OperatorView: View {
    var user: Operator?
    
    var fallbackImage: some View {
        Image(systemName: "person.fill").foregroundColor(.mainColor).frame(width: 16, height: 16)
    }
    
    var avatarImage: some View {
        AsyncImage(
            url: URL(string: user?.avatar ?? ""),
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            if let image = phase.image {
                image.resizable()
                    .scaledToFill()
            } else {
                fallbackImage
            }
        }
        .frame(width: 40, height: 40)
        .background(Color.avatarBackground)
        .overlay(Circle()
            .stroke(Color.mainColor, lineWidth: 1))
        .clipShape(Circle())
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            avatarImage
            
            VStack(alignment:.leading, spacing: 4) {
                Text(user?.name ?? String(localized: "waiting_operator"))
                    .lineLimit(1)
                    .font(.system(size: 18,  weight: .medium))
                    .foregroundColor(.textPrimary)
                
                if (user?.typing == true) {
                    Text("typing")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.textSecondary)
                }
            }.frame(height: 44)
        }
    }
}

struct OperatorView_Preview: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            OperatorView(user: nil)
            OperatorView(user: Operator.init(name: "Operator Name", avatar: nil, typing: false))
            OperatorView(user: Operator.init(name: "Operator Name", avatar: "http://placekitten.com/200/300", typing: false))
            OperatorView(user: Operator.init(name: "Operator Name", avatar: nil, typing: true))
        }
    }
}
