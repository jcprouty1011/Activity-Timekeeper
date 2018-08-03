//
//  Session.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/1/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import Foundation

class Session: NSObject, NSCoding {
    var startTime: Date
    var endTime: Date
    var pausePeriods = [DatePair]()
    var notes: String
    
    var lengthInSeconds: Double {
        let timeDifference = endTime.timeIntervalSince(startTime)
        let pauseLengths = pausePeriods.map {$0.end.timeIntervalSince($0.start)}
        let sessionLength = timeDifference - pauseLengths.reduce(0) {$0 + $1}
        return sessionLength
    }
    
    struct PropertyKeys {
        static let startTime = "startTime"
        static let endTime = "endTime"
        static let pausePeriods = "pausePeriods"
        static let notes = "notes"
    }
    
    init(startTime: Date, endTime: Date, pausePeriods: [DatePair], notes: String) {
        self.startTime = startTime
        self.endTime = endTime
        self.pausePeriods = pausePeriods
        self.notes = notes
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let startTime = aDecoder.decodeObject(forKey: PropertyKeys.startTime) as? Date, let endTime = aDecoder.decodeObject(forKey: PropertyKeys.endTime) as? Date, let pausePeriods = aDecoder.decodeObject(forKey: PropertyKeys.pausePeriods) as? [DatePair], let notes = aDecoder.decodeObject(forKey: PropertyKeys.notes) as? String else {return nil}
        
        self.init(startTime: startTime, endTime: endTime, pausePeriods: pausePeriods, notes: notes)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(startTime, forKey: PropertyKeys.startTime)
        aCoder.encode(endTime, forKey: PropertyKeys.endTime)
        aCoder.encode(pausePeriods, forKey: PropertyKeys.pausePeriods)
        aCoder.encode(notes, forKey: PropertyKeys.notes)
    }
}

class DatePair: NSObject, NSCoding {
    var start: Date
    var end: Date
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
    
    required convenience init? (coder aDecoder: NSCoder) {
        guard let start = aDecoder.decodeObject(forKey: "start") as? Date, let end = aDecoder.decodeObject(forKey: "end") as? Date else {return nil}
        
        self.init(start: start, end: end)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(start, forKey: "start")
        aCoder.encode(end, forKey: "end")
    }
}
