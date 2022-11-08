//
//  Object.swift
//  Gapo-Login
//
//  Created by Dung on 9/26/22.
//

import Foundation
import ObjectMapper
import UIKit


//enum Status: String, Codable {
//    case seenAndRead = "seen_and_read"
//    case seenButUnread = "seen_but_unread"
//
//}
//
//struct Subscription: Codable {
//    let targetID, targetType: String
//    let targetName: String?
//    let level: Int
//
//    enum CodingKeys: String, CodingKey {
//        case targetID = "targetId"
//        case targetType, targetName, level
//    }
//}



class Object: Mappable {
    var id: String = ""
    var userID: Int = 0
    var type = ""
    var uniqueID = ""
    var title: String = ""
    var message = [MessageMap]()
    var image = ""
    var icon: String = ""
    var url: String = ""
    var status: StatusMap = .seenAndRead
    var subscription = [SubscriptionMap?]()
    var readAt = 0
    var createdAt = 0
    var updatedAt = 0
    var receivedAt: Int = 0
    var workspaceID: String? = ""
    var imageThumb: String = ""
    var animation: String = ""
    var tracking: String? = ""
    var subjectName: String = ""
    var isSubscribed: Bool = true
    
    required init?(map: Map){
        }
    
    func mapping(map: Map) {
        id <- map["id"]
        userID <- map["userId"]
        type <- map["type"]
        uniqueID <- map["uniqueId"]
        title <- map["title"]
        message <- map["message"]
        image <- map["image"]
        icon <- map["icon"]
        url <- map["url"]
        status <- map["status"]
        subscription <- map["subscription"]
        readAt <- map["readAt"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        receivedAt <- map["receivedAt"]
        workspaceID <- map["workspaceId"]
        imageThumb <- map["imageThumb"]
        animation <- map["animation"]
        tracking <- map["tracking"]
        subjectName <- map["subjectName"]
        isSubscribed <- map["isSubscribed"]
    }
}

class MessageMap: Mappable {
    var text : String = ""
    var highlights = [HighlightMap]()
    
    required init?(map: Map){
        }
    
    func mapping(map: Map) {
        text <- map["text"]
        highlights <- map["highlights"]
    }
}

class HighlightMap: Mappable {
    var offset: Int = 0
    var length: Int = 0

    required init?(map: Map){
        }
    
    func mapping(map: Map) {
        offset <- map["offset"]
        length <- map["length"]
    }
}
//
enum StatusMap: String {
    case seenAndRead = "seen_and_read"
    case seenButUnread = "seen_but_unread"
}
class SubscriptionMap: Mappable {
    var targetID = ""
    var targetType: String = ""
    var targetName: String? = ""
    var level: Int = 0
    
    required init?(map: Map){
        }
    
    func mapping(map: Map) {
        targetID <- map["targetId"]
        targetType <- map["targetType"]
        targetName <- map["targetName"]
        level <- map["level"]
    }
}

