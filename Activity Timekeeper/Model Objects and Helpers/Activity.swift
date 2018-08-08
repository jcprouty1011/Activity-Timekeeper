//
//  Activity.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/1/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import Foundation

class Activity: NSObject, NSCoding {
    var name: String
    var sessionList: [Session]
    
    struct PropertyKeys {
        static let name = "name"
        static let sessionList = "sessionList"
    }
    
    static let sampleActivities = [Activity(name: "Running", sessionList: []), Activity(name: "Meditation", sessionList: [])]
    
    init(name: String, sessionList: [Session]) {
        self.name = name
        self.sessionList = sessionList
    }
    
    required convenience init? (coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKeys.name) as? String, let sessionList = aDecoder.decodeObject(forKey: PropertyKeys.sessionList) as? [Session] else {return nil}
        
        self.init(name: name, sessionList: sessionList)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(sessionList, forKey: PropertyKeys.sessionList)
    }
    
    
    
}
