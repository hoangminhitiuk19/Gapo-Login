//
//  DataItem.swift
//  Gapo-Login
//
//  Created by Dung on 9/19/22.
//


import Foundation

struct DataItem: Codable {
    
    let id: String
        let userID: Int
        let type, uniqueID, title: String
        let message: Message
        let image, icon: String
        let url: String
        var status: Status
        let subscription: Subscription?
        let readAt, createdAt, updatedAt, receivedAt: Int
        let workspaceID: String?
        let imageThumb: String
        let animation: String
        let tracking: String?
        let subjectName: String
        let isSubscribed: Bool

        enum CodingKeys: String, CodingKey {
            case id
            case userID = "userId"
            case type
            case uniqueID = "uniqueId"
            case title, message, image, icon, url, status, subscription, readAt, createdAt, updatedAt, receivedAt
            case workspaceID = "workspaceId"
            case imageThumb, animation, tracking, subjectName, isSubscribed
        }}
