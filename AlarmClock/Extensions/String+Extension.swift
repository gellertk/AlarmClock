//
//  String+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import Foundation

extension String {
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.date(from: self) ?? Date()
    }
    
}

