//
//  SessionPlotCell.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/7/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

class SessionPlotCell: UITableViewCell {

    @IBOutlet weak var sessionPlotView: SessionPlotView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}
