//
//  Format.swift
//  SDK Demo
//
//  Created by Ростислав Ляшев on 23.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import Foundation
import chat2desk_sdk

func formatBytes(_ bytes: Int32, decimals: Int = 2) -> String {
    if (bytes == 0) {
        return "0 Bytes"
    }
    
    let b = Double(bytes)
    let k: Double = 1024.0
    let dm = decimals < 0 ? 0 : decimals
    
    let sizes = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
    
    let i = Int(floor(log(b) / log(k)))
    
    let result = b / pow(k, Double(i))
    
    return String(format: "%.\(dm)f \(sizes[i])", result)
}

func messageDate(milliseconds: Int64) -> String {
    let dateLocalTime = Date(timeIntervalSince1970: Double(milliseconds / 1000))
    let currentDate = Date()
    
    //Yesterday
    if (currentDate.distance(from: dateLocalTime, only: .day) == 1) {
        return "yestarday"
    }
    
    var format = "dd MMM HH:mm"
    //Current day
    if (currentDate.hasSame(.day, as: dateLocalTime)) {
        format = "HH:mm"
    }
    
    return formatDate(date: dateLocalTime, format: format)
}

func formatDate(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

extension Date {
    
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }
    
    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }
    
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
}
