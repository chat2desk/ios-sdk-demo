//
//  FileMetadata.swift
//  iosDemo
//
//  Created by Ростислав Ляшев on 23.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import Foundation
import AVFoundation
import chat2desk_sdk

struct AttachmentMeta {
    let contentUri: URL?
    var originalName: String = ""
    var fileSize: Int32 = 0
    let mimeType: String
}

extension AttachmentMeta {
    func toDomain() -> chat2desk_sdk.AttachmentMeta? {
        if let url = contentUri {
            return chat2desk_sdk.AttachmentMeta.Companion().fromURL(url: url, originalName: originalName, mimeType: mimeType, fileSize: fileSize)
        }
        return nil
    }
}

func getFileMetadata(url: URL) -> AttachmentMeta {
    return AttachmentMeta(
        contentUri: url,
        originalName: url.originalName,
        fileSize: Int32(url.fileSize),
        mimeType: url.mimeType()
    )
}


extension URL {
    public func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
    
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    
    var originalName: String {
        return FileManager.default.displayName(atPath: path)
    }
}
