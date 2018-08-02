//
//  DataManager.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/2/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import Foundation

struct DataManager {
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let shared = DataManager()
    
    func saveActivities (activities: [Activity]) {
        let activityURL = documentsDirectory.appendingPathComponent("activities")
        NSKeyedArchiver.archiveRootObject(activities, toFile: activityURL.path)
    }
    
    func loadActivities () -> [Activity]? {
        let activityURL = documentsDirectory.appendingPathComponent("activities")
        return NSKeyedUnarchiver.unarchiveObject(withFile: activityURL.path) as? [Activity]
    }
    
}
