//
// Created by Rostislav Lyashev on 18.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI

public struct GreyOutOfFocusView: View {
    let opacity: CGFloat
    let callback: (() -> ())?

    public init(
            opacity: CGFloat = 0.7,
            callback: (() -> ())? = nil
    ) {
        self.opacity = opacity
        self.callback = callback
    }

    var greyView: some View {
        Rectangle()
                .background(Color.gray)
                .opacity(0.7)
                .onTapGesture {
                    callback?()
                }
                .ignoresSafeArea()
    }

    public var body: some View {
        greyView
    }
}

struct GreyOutOfFocusView_Previews: PreviewProvider {
    static var previews: some View {
        GreyOutOfFocusView()
    }
}
