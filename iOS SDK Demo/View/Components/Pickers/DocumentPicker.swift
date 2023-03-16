//
//  DocumentPicker.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 20.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//
import UniformTypeIdentifiers
import SwiftUI
import UIKit

struct DocumentPicker: UIViewControllerRepresentable {
    var sourceType: [UTType]
    var onSelect: (_ url: URL) -> ()
    var onCancel: (() -> ())?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: sourceType, asCopy: true)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        var parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls:[URL]) {
            if (!urls.isEmpty) {
                parent.onSelect(urls.first!)
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.onCancel?()
        }
    }
}
