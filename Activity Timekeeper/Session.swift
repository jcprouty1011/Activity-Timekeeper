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
    
    var lengthInMinutes: Double {
        let timeDifference = endTime.timeIntervalSince(startTime)
        return timeDifference
    }
}
