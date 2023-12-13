//
//  Chat2DeskViewModel.swift
//  iOS SDK Demo
//
//  Created by Ростислав Ляшев on 11.12.2023.
//

import chat2desk_sdk

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
    
    init() {
        self.chat2desk = Self.createChat2Desk()
        
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
    
    private static func createChat2Desk() -> Chat2Desk {
        let dictionary = Bundle.main.infoDictionary
        let settings = Settings.init(
            authToken: dictionary?["WIDGET_TOKEN"] as? String ?? "",
            baseHost: dictionary?["BASE_HOST"] as? String ?? "",
            wsHost: dictionary?["WS_HOST"] as? String ?? "",
            storageHost: dictionary?["STORAGE_HOST"] as? String ?? ""
        )
        
        // Example of custom socket configuration
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        settings.socketConfiguration = configuration
        
#if DEBUG
        settings.withLog = true
        settings.logLevel = .info
#endif
        
        return Chat2Desk.Companion().create(settings: settings)
    }
    
    deinit {
        chat2desk.close()
        messagesWatcher?.close()
        operatorWatcher?.close()
        connectionStatusWatcher?.close()
        errorWatcher?.close()
        customFieldsWatcher?.close()
    }
}
