//
//  Activity.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/1/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import Foundation

struct Activity {
    var name: String
    var sessionList: [Session]
    
    static let sampleActivities = [Activity(name: "Running", sessionList: []), Activity(name: "Meditation", sessionList: [])]
}
