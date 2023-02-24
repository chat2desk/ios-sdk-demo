//
// Created by Rostislav Lyashev on 18.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI

public struct ActionSheetCardItem: View {
    let id = UUID()
    let sfSymbolName: String?
    let label: LocalizedStringKey
    let labelFont: Font
    let iconForegroundColor: Color
    let foregroundColor: Color
    let foregroundInactiveColor: Color
    let callback: (() -> ())?

    public init(
            sfSymbolName: String? = nil,
            label: LocalizedStringKey,
            labelFont: Font = Font.headline,
            iconForegroundColor: Color = Color.mainColor,
            foregroundColor: Color = Color.textPrimary,
            foregroundInactiveColor: Color = Color.gray,
            callback: (() -> ())? = nil
    ) {
        self.sfSymbolName = sfSymbolName
        self.label = label
        self.labelFont = labelFont
        self.iconForegroundColor = iconForegroundColor
        self.foregroundColor = foregroundColor
        self.foregroundInactiveColor = foregroundInactiveColor
        self.callback = callback
    }

    func buttonView() -> some View {
        HStack {
            if let sfSymbolName = sfSymbolName {
                Image(systemName: sfSymbolName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 19, height: 19)
                        .padding(.vertical)
                        .padding(.horizontal, 10)
                        .foregroundColor(iconForegroundColor)
            }

            Text(label)
                    .font(labelFont)

            Spacer()
        }
    }

    public var body: some View {
        Group {
            if let callback = callback {
                Button(action: {
                    callback()
                }) {
                    buttonView()
                            .foregroundColor(foregroundColor)
                }
            } else {
                buttonView()
                        .foregroundColor(foregroundInactiveColor)
            }
        }
    }
}

struct ActionSheetCardItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ActionSheetCardItem(sfSymbolName: "film", label: "photo_video") {
                //
            }

            ActionSheetCardItem(sfSymbolName: "doc.text", label: "file") {
                //
            }

            ActionSheetCardItem(sfSymbolName: "doc.text", label: "file")
            Spacer()
        }
    }
}
