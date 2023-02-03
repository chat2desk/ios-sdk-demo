//
//  DeliveryStatus.swift
//  iosDemo
//
//  Created by Ростислав Ляшев on 23.01.2023.
//  Copyright © 2023 Chat2Desk. All rights reserved.
//

import chat2desk_sdk

func statusIcon(_ status: DeliveryStatus) -> String {
    switch status {
    case .sending:
        return "clock"
    case .notDelivered:
        return "xmark"
    case .sent:
        return "checkmark"
    default:
        return "checkmark.circle.fill"
    }
}
