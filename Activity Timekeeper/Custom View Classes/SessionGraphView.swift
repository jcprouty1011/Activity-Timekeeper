//
//  SessionGraphView.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/8/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

class SessionGraphView: UIView {

    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .orange
    var graphType: GraphType!
    var activity: Activity!
    var numPoints: Int = 7
    var xPoints = [CGFloat]()
    var yPoints = [CGFloat]()
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        static let margin: CGFloat = 20.0
        static let topSpace: CGFloat = 20.0
        static let bottomSpace: CGFloat = 20.0
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.cornerRadius)
        path.addClip()
        
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: colorLocations)!
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        definePlotPoints(rect)
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: xPoints[0], y: yPoints[0]))
        for i in 1..<numPoints {
            graphPath.addLine(to: CGPoint(x: xPoints[i], y: yPoints[i]))
        }
        UIColor.white.setStroke()
        graphPath.stroke()
    }
    
    func definePlotPoints(_ rect: CGRect) {
        let count = activity.sessionList.count
        if count < numPoints {
            numPoints = count
        }
        let sessionSubset = activity.sessionList[(count - numPoints)..<count]
        
        let timeValues = sessionSubset.map{-$0.startTime.timeIntervalSinceNow}
        xPoints = timeValues.map{CGFloat((timeValues.max()! - $0) / (timeValues.max()! - timeValues.min()!)) * (rect.width - Constants.margin * 2) + Constants.margin}
        switch graphType {
        case .individual:
            let lengthValues = sessionSubset.map{$0.lengthInSeconds}
            yPoints = lengthValues.map{rect.height - CGFloat(($0 - lengthValues.min()!) / lengthValues.max()!) * (rect.height - Constants.topSpace - Constants.bottomSpace) - Constants.bottomSpace}
        case .cumulative:
            var totalSoFar: Double = 0
            var lengthValues: [Double] = []
            for session in sessionSubset {
                totalSoFar += session.lengthInSeconds
                lengthValues.append(totalSoFar)
            }
            yPoints = lengthValues.map{rect.height - CGFloat(($0 - lengthValues.min()!) / lengthValues.max()!) * (rect.height - Constants.topSpace - Constants.bottomSpace) - Constants.bottomSpace}
        default:
            yPoints = sessionSubset.map{_ in CGFloat(0)}
        }
    }
    

}

enum GraphType {
    case individual
    case cumulative
}
