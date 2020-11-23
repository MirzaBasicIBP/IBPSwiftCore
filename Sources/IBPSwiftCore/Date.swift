//
//  Date.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 23/11/2020.
//

import Foundation

extension IBPSwiftCore {
   internal class DateCore {
        
        init() {}
        static var utcFirstDateOn1970: String  {
            return  Date(timeIntervalSince1970: 0).utcString()
        }
    }
}

extension Date {
   public func utcString() -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
       formatter.timeZone = TimeZone(secondsFromGMT: 0)
       return formatter.string(from: self)
    }
}
