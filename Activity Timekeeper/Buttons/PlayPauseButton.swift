//
//  PlayPauseButton.swift
//  Activity Timekeeper
//
//  Created by Jeffrey Prouty on 8/7/18.
//  Copyright © 2018 Jeffrey Prouty. All rights reserved.
//

import UIKit

@IBDesignable class PlayPauseButton: UIButton {
    
    var isPlaying = false

    private struct Constants {
        static let pauseLineWidth: CGFloat = 5.0
        static let interiorScale: CGFloat = 0.65
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        path.fill()
        
        let radius = min(bounds.width/2, bounds.height/2) * Constants.interiorScale
        let bigRadius = min(bounds.width/2, bounds.height/2)
        
        if !isPlaying {
            let trianglePath = UIBezierPath()

            trianglePath.move(to: CGPoint(x: bigRadius - radius/2, y:bigRadius + radius * CGFloat(cos(Double.pi / 6))))
            trianglePath.addLine(to: CGPoint(x: bigRadius - radius/2, y:bigRadius - radius * CGFloat(cos(Double.pi / 6))))
            trianglePath.addLine(to: CGPoint(x: bigRadius + radius, y: bigRadius))
            trianglePath.addLine(to: CGPoint(x: bigRadius - radius/2, y:bigRadius + radius * CGFloat(cos(Double.pi / 6))))
            
            UIColor.white.setFill()
            trianglePath.fill()
        } else {
            let pausePath = UIBezierPath()
            pausePath.lineWidth = Constants.pauseLineWidth
            
            pausePath.move(to: CGPoint(x: bigRadius - radius/3, y: bigRadius - radius * CGFloat(cos(Double.pi / 6))))
            pausePath.addLine(to: CGPoint(x: bigRadius - radius/3, y: bigRadius + radius * CGFloat(cos(Double.pi / 6))))
            pausePath.move(to: CGPoint(x: bigRadius + radius/3, y: bigRadius - radius * CGFloat(cos(Double.pi / 6))))
            pausePath.addLine(to: CGPoint(x: bigRadius + radius/3, y: bigRadius + radius * CGFloat(cos(Double.pi / 6))))
            
            UIColor.white.setStroke()
            pausePath.stroke()
        }
        
    }
    

}
