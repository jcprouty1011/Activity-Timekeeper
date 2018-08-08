//
//  SessionPlotView.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/7/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

class SessionPlotView: UIView {

    var session: Session!
    var overallScale: Double!
    
    struct Constants {
        static let margins: CGFloat = 5.0
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let totalTime = session.endTime.timeIntervalSince(session.startTime)
        let pausePoints = session.pausePeriods.map{$0.start.timeIntervalSince(session.startTime)}
        let pauseLengths = session.pausePeriods.map{$0.end.timeIntervalSince($0.start)}
        
        let rectPath = UIBezierPath(rect: CGRect(x: Constants.margins, y: Constants.margins, width: (CGFloat(totalTime / overallScale) * (rect.width - 2 * Constants.margins)), height: rect.height - 2 * Constants.margins))
        
        UIColor.green.setFill()
        rectPath.fill()
        if pausePoints.count >= 1{
            for i in 0...(pausePoints.count - 1) {
                let pausePath = UIBezierPath(rect: CGRect(x: Constants.margins + CGFloat(pausePoints[i] / overallScale) * (rect.width - 2 * Constants.margins), y: Constants.margins, width: (CGFloat(pauseLengths[i] / overallScale) * (rect.width - 2 * Constants.margins)), height: rect.height - 2 * Constants.margins))
                UIColor.white.setFill()
                pausePath.fill()
            }
        }
    }
    

}
