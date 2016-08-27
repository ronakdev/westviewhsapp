//
//  Period.swift
//  Westview
//
//  Created by Ronak Shah on 8/27/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import Foundation

class Period {
    var name:String
    var start: NSDate
    var end: NSDate
    
    init(name:String, start:NSDate, end:NSDate) {
        self.name = name
        self.start = start
        self.end = end
    }
}