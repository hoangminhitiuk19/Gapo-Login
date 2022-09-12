//
//  CheckingEmailData.swift
//  Gapo-Login
//
//  Created by Dung on 9/6/22.
//

import Foundation

struct Result: Decodable {
    let code: Int
    let message: String
    let data: DataClass
    
//    enum CodingKeys: String, CodingKey {
//        case code
//        case message
//        case data = "results"
//      }
}

