//
//  NewActivityViewController.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/1/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

class NewActivityViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        if segue.identifier == "saveUnwindSegue" {
            let newActivity = Activity(name: nameTextField.text!, sessionList: [])
            DataManager.shared.activities.append(newActivity)
        }
    }
    

}
