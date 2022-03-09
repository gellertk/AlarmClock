//
//  TimeIntervalExtensions.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

extension TimeInterval{
    
    func convertToString() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 100)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        
        return String(format: "%0.2d:%0.2d,%0.2d", minutes, seconds, ms)
    }
    
}
