//
//  Extensions.swift
//  Westview
//
//  Created by Ronak Shah on 8/21/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation
extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}
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
    
    static func make(hours: Int, minutes: Int) -> NSDate{
        let calendar = NSCalendar.currentCalendar()
        let comps = NSDateComponents()
        comps.hour = hours
        comps.minute = minutes
        comps.day = NSDate().day()!
        let date = calendar.dateFromComponents(comps)
        return date!
    }
    
    func clockTime() -> String {
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: self)
        let hour = comp.hour
        let minute = comp.minute
        if (minute < 10) {
            return "\(hour):0\(minute)"

        }
        
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