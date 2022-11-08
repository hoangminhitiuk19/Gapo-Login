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

extension String {
    func createDateTime(format: String) -> String {
        var strDate = ""
        if let unixTime = Double(self) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "GET"
            dateFormatter.timeZone = TimeZone(abbreviation: timezone)
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = format
            strDate = dateFormatter.string(from: date)
        }
        return strDate
    }
}


public extension UITableView {
    
    func scrollToTop(section: Int) {
        if numberOfRows(inSection: section) > 0 {
            scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
        }
    }
    
    func registerCell(nib: String) {
        self.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
    }
    
    func registerNibsWith(names: [String], bundle: Bundle? = nil) {
        for name in names {
            self.register(UINib(nibName: name, bundle: bundle), forCellReuseIdentifier: name)
        }
    }
}

public extension NSObject {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    class var nibName: String {
        return String(describing: self)
    }
    
    class var bundle: Bundle {
        Bundle(for: Self.self)
    }
}
