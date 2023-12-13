//
//  HomeViewModel.swift
//  iOS SDK Demo
//
//  Created by Ростислав Ляшев on 11.12.2023.
//

import Foundation
import chat2desk_sdk

class HomeViewModel: ObservableObject {
    @Published public var isInited: Bool = false
    
    init() {
        isInited = true;
    }
}
