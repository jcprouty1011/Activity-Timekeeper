//
//  ActivityDetailViewController.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/1/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    var activity: Activity!
    var sessionTableViewController: SessionTableViewController!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var sessionGraphView: SessionGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLabel.text = activity.name
        sessionGraphView.activity = activity
        sessionGraphView.graphType = .cumulative

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ActivityDetailToSessionSegue" {
            let sessionViewController = segue.destination as! SessionViewController
            sessionViewController.activity = activity
        } else if segue.identifier == "EmbedSessionTable" {
            let sessionTableViewController = segue.destination as! SessionTableViewController
            sessionTableViewController.sessions = activity.sessionList
            self.sessionTableViewController = sessionTableViewController
        }
    }
    
    @IBAction func unwindToActivityDetail(segue: UIStoryboardSegue) {
        sessionTableViewController.sessions = activity.sessionList
        sessionTableViewController.tableView.reloadData()
        sessionGraphView.setNeedsDisplay()
    }
 

}
