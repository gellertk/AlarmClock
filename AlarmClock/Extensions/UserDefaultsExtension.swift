//
//  UserDefaultsExtensions.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 10.02.2022.
//

import Foundation

extension UserDefaults {
    
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        
        return isFirstLaunch
    }
    
}
