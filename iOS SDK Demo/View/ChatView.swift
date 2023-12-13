//
//  ChatView.swift
//  iOS SDK Demo
//
//  Created by Ростислав Ляшев on 11.12.2023.
//

import SwiftUI
import chat2desk_sdk

struct ChatView: View {
    @StateObject var viewModel: Chat2DeskViewModel = Chat2DeskViewModel()

    var body: some View {
        Chat().environmentObject(self.viewModel)
    }
}
