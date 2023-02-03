//
//  ConnectionStatus.swift
//  iosDemo
//
//  Created by Ростислав Ляшев on 19.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

struct ConnectionStatus: View {
    var connectionStatus: ConnectionState?
    var onConnect: () -> ()
    var onDisconect: () -> ()
    
    func ConnectionButton(_ iconName: String, action: @escaping () -> ()) -> some View {
        return Button(action: action) {
            Image(systemName: iconName)
                .foregroundColor(.white)
        }
        .frame(width: 34, height: 34)
        .background(Color.mainColor)
        .clipShape(Circle())
    }
    
    
    var connectButton: some View {
        ConnectionButton("play.fill") {
            onConnect()
        }
    }
    
    var disconnectButton: some View {
        ConnectionButton("pause.fill") {
            onDisconect()
        }
    }
    
    
    var body: some View {
        HStack(alignment: .center){
            Text("connection_status: \(connectionStatus?.name ?? "")")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.textPrimary)
            Spacer()
            
            if (connectionStatus == .connected) {
                disconnectButton
            }
            if (connectionStatus == .closed) {
                connectButton
            }
        }.frame(height: 44)
    }
}


struct ConnectionStatus_Preview: PreviewProvider {
    static var previews: some View {
        ConnectionStatus(connectionStatus: .connected, onConnect: {}, onDisconect: {})
        ConnectionStatus(connectionStatus: .closed, onConnect: {}, onDisconect: {})
        ConnectionStatus(connectionStatus: .connecting, onConnect: {}, onDisconect: {})
        ConnectionStatus(connectionStatus: .closing, onConnect: {}, onDisconect: {})
    }
}
