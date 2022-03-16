//
//  TimeIntervalExtensions.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

//TODO: fix rounding
extension TimeInterval {
    
    func convertToStopwatchFormatString() -> String {
        
        let time = NSInteger(self)
        
        let hours = (time / 3600)
        let minutes = (time / 60) % 60
        let seconds = time % 60
        var ms = 0
        if let range = String(self).range(of: ".") {
            ms = Int(String(self)[range.upperBound...].prefix(2)) ?? 0
        }
        
        if hours == 0 {
            return String(format: "%0.2d:%0.2d,%0.2d", minutes, seconds, ms)
        } else {
            return String(format: "%0.2d:%0.2d:%0.2d,%0.2d", hours, minutes, seconds, ms)
        }
    }
    
}
