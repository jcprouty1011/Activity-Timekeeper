//
//  Session.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/1/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import Foundation

struct Session {
    var startTime: Date
    var endTime: Date
    var pausePeriods = [(Date, Date)]()
    var notes: String
    
    var lengthInSeconds: Double {
        let timeDifference = endTime.timeIntervalSince(startTime)
        let pauseLengths = pausePeriods.map {$0.1.timeIntervalSince($0.0)}
        let sessionLength = timeDifference - pauseLengths.reduce(0) {$0 + $1}
        return sessionLength
    }
}
