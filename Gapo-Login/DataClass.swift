//
//  DataClass.swift
//  Gapo-Login
//
//  Created by Dung on 9/6/22.
//

import Foundation

struct DataClass: Decodable {
    let newDomain: Bool
    let salt: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case newDomain = "new_domain"
        case salt
        case userID = "user_id"
    }
}
