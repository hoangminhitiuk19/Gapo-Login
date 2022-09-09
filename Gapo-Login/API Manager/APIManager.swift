//
//  APIManager.swift
//  Gapo-Login
//
//  Created by Dung on 9/6/22.
//

import Foundation
import Alamofire

class APIManager {
//    static let shareInstance = APIManager()
//    
//    func callingLoginAPI(login: LoginModel, completionHandler: (Swift.Result<Any?, APIErrors>) -> Void ) {
//        let headers: HTTPHeaders = [
//            .contentType("application/json")
//        ]
//    
//        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{ response in debugPrint(response)
//            switch response.result {
//            case .success(let data):
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                    if response.response?.statusCode == 200 {
//                        completionHandler(.success(json))
//                    } else {
//                        completionHandler(.failure(.custom(message: "")))
//                    }
//                }
//            }
//        }
//    }
//}
//
}
enum APIErrors: Error {
case custom(message: String)
}

typealias Handler = (Swift.Result<Any?, APIErrors>) -> Void
