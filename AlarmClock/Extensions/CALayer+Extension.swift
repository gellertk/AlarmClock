//
//  CALayer+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 30.04.2022.
//

import UIKit

extension CALayer {
    
    func addStopwatchBasicAnimation(duration: TimeInterval, currentSecond: CGFloat) {
        speed = 1.0
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = degree2Radian(floatNumber: currentSecond)
        animation.byValue = 2 * Double.pi
        animation.duration = duration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        add(animation, forKey: "secondsHandAnimation")
    }
    
    func pauseStopwatchAnimation() {
        let pausedTime : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }
    
    func resumeStopwatchAnimation() {
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        beginTime = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    }
    
    func resetStopwatchAnimation() {
        pauseStopwatchAnimation()
        timeOffset = 0.0
        beginTime = 0.0
    }
    
    private func degree2Radian(floatNumber: CGFloat) -> CGFloat {        
        return CGFloat(Double.pi) * floatNumber / 180
    }
    
}
