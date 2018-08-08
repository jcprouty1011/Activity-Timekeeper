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
    var isTimerRunning = false {
        didSet {
            startPauseButton.isPlaying = isTimerRunning
            startPauseButton.setNeedsDisplay()
        }
    }
    var startTime: Date!
    var endTime: Date!
    var pausedAt: Date!
    var pauseTimes: [DatePair] = []
    var totalPauseTime: TimeInterval = 0

    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: PlayPauseButton!
    @IBOutlet weak var saveSessionButton: UIButton!
    @IBOutlet weak var cancelSessionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveSessionButton.isEnabled = false
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
                saveSessionButton.isEnabled = true
            } else {
                let resumedAt = Date()
                pauseTimes.append(DatePair(start: pausedAt, end: resumedAt))
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
        startPauseButton.isPlaying = isTimerRunning
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
        if isTimerRunning {
            isTimerRunning = false
            pausedAt = Date()
            timer.invalidate()
        }
        let alert = UIAlertController(title: "Save", message: "Would you like to finish and save this session?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            self.endTime = self.pausedAt
            let session = Session(startTime: self.startTime, endTime: self.endTime, pausePeriods: self.pauseTimes, notes: "")
            self.activity.sessionList.append(session)
            DataManager.shared.saveActivities()
            self.performSegue(withIdentifier: "SessionToActivityDetail", sender: nil)
        } ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelSessionButtonTapped(_ sender: Any) {
        if isTimerRunning {
            isTimerRunning = false
            pausedAt = Date()
            timer.invalidate()
        }
        if startTime != nil {
            let alert = UIAlertController(title: "Cancel", message: "Would you like to abort this session? The session will not be saved.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.performSegue(withIdentifier: "SessionToActivityDetail", sender: nil)
            } ))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
            present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "SessionToActivityDetail", sender: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
 

}
