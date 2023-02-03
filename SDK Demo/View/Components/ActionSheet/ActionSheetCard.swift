//
// Created by Rostislav Lyashev on 18.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI
import Combine

public struct ActionSheetCard: View {
    @State var offset = UIScreen.main.bounds.height
    @Binding var isShowing: Bool
    
    let items: [ActionSheetCardItem]
    let heightToDisappear = UIScreen.main.bounds.height
    let cellHeight: CGFloat = 50
    let backgroundColor: Color
    
    public init(
        isShowing: Binding<Bool>,
        items: [ActionSheetCardItem],
        backgroundColor: Color = Color.white
    ) {
        _isShowing = isShowing
        self.items = items
        self.backgroundColor = backgroundColor
    }
    
    func hide() {
        offset = heightToDisappear
        isShowing = false
    }
    
    var itemsView: some View {
        VStack {
            ForEach(0..<items.count) { index in
                if index > 0 {
                    Divider()
                }
                items[index]
                    .frame(height: cellHeight)
            }
        }
        .padding()
    }
    
    var interactiveGesture: some Gesture {
        DragGesture()
            .onChanged({ (value) in
                if value.translation.height > 0 {
                    offset = value.location.y
                }
            })
            .onEnded({ (value) in
                let diff = abs(offset - value.location.y)
                if diff > 100 {
                    hide()
                } else {
                    offset = 0
                }
            })
    }
    
    var outOfFocusArea: some View {
        Group {
            if isShowing {
                GreyOutOfFocusView {
                    self.isShowing = false
                }
            }
        }
    }
    
    var sheetView: some View {
        VStack {
            Spacer()
            
            VStack {
                itemsView
                Text("").frame(height: 20) // empty space
            }
            .background(backgroundColor)
            .cornerRadius(4)
            .offset(y: offset)
            .gesture(interactiveGesture)
            .onTapGesture {
                hide()
            }
        }
    }
    
    var bodyContet: some View {
        ZStack {
            outOfFocusArea
            sheetView
        }
    }
    
    public var body: some View {
        Group {
            if isShowing {
                bodyContet
            }
        }
        .ignoresSafeArea()
        .animation(Animation.default, value: isShowing)
        .onReceive(Just(isShowing), perform: { isShowing in
            offset = isShowing ? 0 : heightToDisappear
        })
    }
}

struct ActionSheetCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ActionSheetCard(isShowing: .constant(true), items: [
                ActionSheetCardItem(sfSymbolName: "film", label: "photo_video") {
                },
                ActionSheetCardItem(sfSymbolName: "doc.text", label: "file") {
                }
            ])
        }
    }
}
