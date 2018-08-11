//
//  SessionDetailViewController.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/8/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

class SessionDetailViewController: UITableViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    var session: Session!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        dateLabel.text = "Date: \(dateFormatter.string(from:session.startTime))"
        lengthLabel.text = "Length: \(String(format: "%.1f", session.bestUnitRepresentation())) \(session.bestUnit().unitLabel())"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [1, 0]:
            return 300
        default:
            return 44
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
