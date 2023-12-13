//
//  SDK_DemoApp.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 20.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import chat2desk_sdk

@main
struct SDK_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationTabs()
                .colorScheme(.light)
        }
    }
}
