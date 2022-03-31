//
//  CAShapeLayer.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 31.03.2022.
//

import UIKit

extension CAShapeLayer {
    
    func addBasicAnimation(duration: TimeInterval) {
        speed = 1
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = duration
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        add(basicAnimation, forKey: "basicAnimation")
    }
    
    func pauseAnimation() {
        let pausedTime : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
    }
    
}
