//
//  DateExtensions.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 10.02.2022.
//

import Foundation

extension Date {
    
    func convertToTimeFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: self)
    }

}
