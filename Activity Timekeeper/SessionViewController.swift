//
//  SessionViewController.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/2/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    
    var activity: Activity!
    var timer = Timer()
    var isTimerRunning = false
    var startTime: Date!
    var endTime: Date!
    var pausedAt: Date!
    var pauseTimes: [(Date, Date)] = []
    var totalPauseTime: TimeInterval = 0

    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var saveSessionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLabel.text = "Activity: \(activity.name)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startPauseButtonTapped(_ sender: UIButton) {
        if !isTimerRunning {
            if startTime == nil {
                startTime = Date()
            } else {
                let resumedAt = Date()
                pauseTimes.append((resumedAt, pausedAt))
                totalPauseTime += resumedAt.timeIntervalSince(pausedAt)
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(timer) in
                let timeInterval = -self.startTime.timeIntervalSinceNow - self.totalPauseTime
                self.timerLabel.text = SessionViewController.makeTimerLabel(timeInterval: timeInterval)
            })
        } else {
            pausedAt = Date()
            timer.invalidate()
        }
        
        isTimerRunning = !isTimerRunning
    }
    
    static func makeTimerLabel(timeInterval: TimeInterval) -> String {
        let deciseconds = Int((timeInterval*10).truncatingRemainder(dividingBy: 10))
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int((timeInterval/60).truncatingRemainder(dividingBy: 60))
        let hours = Int(timeInterval/3600)
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i.%i", minutes, seconds, deciseconds)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
 

}
