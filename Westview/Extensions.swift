//
//  Extensions.swift
//  Westview
//
//  Created by Ronak Shah on 8/21/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
    
    convenience init (hours: Double, minutes: Double) {
        let time: NSTimeInterval = (3600 * hours) + (60 * minutes)
        self.init(timeIntervalSinceNow: time)
    }
    
    func clockTime() -> String {
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: self)
        let hour = comp.hour
        let minute = comp.minute
        
        return "\(hour):\(minute)"
    }
    
    func day() -> Int? {
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) {
            return comp.weekday
        } else {
            return nil
        }
    }
    
    
}