//
//  ViewControllerExtension.swift
//  Gapo-Login
//
//  Created by Dung on 9/23/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func createDateTime(timestamp: String) -> String {
        var strDate = ""
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "GET"
            dateFormatter.timeZone = TimeZone(abbreviation: timezone)
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            strDate = dateFormatter.string(from: date)
        }
        return strDate
    }
    
    
}
