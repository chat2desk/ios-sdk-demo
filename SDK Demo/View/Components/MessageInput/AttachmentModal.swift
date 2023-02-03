//
// Created by Rostislav Lyashev  on 19.01.2023.
// Copyright (c) 2023 Chat2Desk. All rights reserved.
//

import SwiftUI

struct AttachmentModal: View {
    @Binding var isShowing: Bool
    @Binding var attachment: AttachmentMeta?
    
    @State private var isShowPhotoLibrary = false
    @State private var isShowDocumentPicker = false
    
    func handleSelectAttachment(url: URL) -> Void {
        attachment = getFileMetadata(url: url)
        isShowing = false
    }
    
    func handleCancel() -> Void {
        isShowing = false
    }
    
    var body: some View {
        ActionSheetCard(isShowing: $isShowing, items: [
            ActionSheetCardItem(sfSymbolName: "film", label: "photo_video") {
                isShowPhotoLibrary.toggle()
            },
            ActionSheetCardItem(sfSymbolName: "doc.text", label: "file") {
                isShowDocumentPicker.toggle()
            }
        ]).sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, onSelect: handleSelectAttachment(url:), onCancel: handleCancel)
        }.sheet(isPresented: $isShowDocumentPicker) {
            DocumentPicker(sourceType: [.item], onSelect: handleSelectAttachment(url:), onCancel: handleCancel)
        }
    }
}

struct AttachmentModal_Preview: PreviewProvider {
    static var previews: some View {
        AttachmentModal(isShowing: .constant(true), attachment: .constant(nil))
    }
}
