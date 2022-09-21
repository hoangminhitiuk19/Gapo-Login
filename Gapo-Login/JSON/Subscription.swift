//
//  Subscription.swift
//  Gapo-Login
//
//  Created by Dung on 9/19/22.
//

import Foundation

// MARK: - Subscription
struct Subscription: Codable {
    let targetID, targetType: String
    let targetName: String?
    let level: Int

    enum CodingKeys: String, CodingKey {
        case targetID = "targetId"
        case targetType, targetName, level
    }
}

