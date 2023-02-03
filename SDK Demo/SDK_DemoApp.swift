//
//  SDK_DemoApp.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 01.02.2023.
//

import SwiftUI
import chat2desk_sdk

@main
struct SDK_DemoApp: App {
    let observedChat2Desk: Chat2DeskViewModel
    
    init() {
#if DEBUG
        let isDebug = true
#else
        let isDebug = false
#endif
        
        let dictionary = Bundle.main.infoDictionary
        let settings = Settings.init(
            authToken: dictionary?["WIDGET_TOKEN"] as? String ?? "",
            baseHost: dictionary?["BASE_HOST"] as? String ?? "",
            wsHost: dictionary?["WS_HOST"] as? String ?? "",
            storageHost: dictionary?["STORAGE_HOST"] as? String ?? "",
            inMemory: false,
            withLog: KotlinBoolean(bool: isDebug)
        )
        let chat2desk = Chat2Desk.Companion().create(settings: settings)
        
        observedChat2Desk = Chat2DeskViewModel(chat2desk: chat2desk)
    }
    
    var body: some Scene {
        WindowGroup {
            Chat().environmentObject(observedChat2Desk)
                .onAppear {
                    Task {
                        try await observedChat2Desk.chat2desk.start()
                    }
                }.onDisappear {
                    Task {
                        try await observedChat2Desk.chat2desk.stop()
                    }
                }
        }
    }
}

class Chat2DeskViewModel: ObservableObject {
    @Published public var messages: [Message] = []
    @Published public var responder: Operator? = nil
    @Published public var connectionStatus: ConnectionState? = nil
    @Published public var error: KotlinThrowable? = nil
    @Published public var customFields: [CustomField] = []
    
    public let chat2desk: Chat2Desk
    
    var messagesWatcher: Closeable?
    var operatorWatcher: Closeable?
    var connectionStatusWatcher: Closeable?
    var errorWatcher: Closeable?
    var customFieldsWatcher: Closeable?
    
    init(chat2desk: Chat2Desk) {
        self.chat2desk = chat2desk
        
        messagesWatcher = chat2desk.watchMessages().watch { [weak self] messages in
            self?.messages = messages?.compactMap({ $0 as? Message }) ?? []
        }
        
        operatorWatcher = chat2desk.watchOperator().watch { [weak self] responder in
            self?.responder = responder
        }
        
        connectionStatusWatcher = chat2desk.watchConnectionStatus().watch { [weak self] status in
            self?.connectionStatus = status
        }
        
        errorWatcher = chat2desk.watchError().watch { [weak self] error in
            self?.error = error
        }
        
        customFieldsWatcher = chat2desk.watchCustomFields().watch { [weak self] customFields in
            self?.customFields = customFields?.compactMap({ $0 as? CustomField }) ?? []
        }
    }
    
    deinit {
        messagesWatcher?.close()
        operatorWatcher?.close()
        connectionStatusWatcher?.close()
        errorWatcher?.close()
        customFieldsWatcher?.close()
    }
}
