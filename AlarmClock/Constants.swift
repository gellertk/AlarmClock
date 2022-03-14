//
//  Constants.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class Constants {
    
    static let buttonColor = UIColor.systemOrange
    static let worldClockCellId = "worldClockCellId"
    static let timeZoneCellId = "timeZoneCellId"
    static let lapCellId = "lapCellId"
    static let firstLaunchWorldClocksCities = [
       "Москва",
       "Калининград",
       "Омск",
       "Екатеринбург"
      ]
    static let timeZoneTableViewColor = UIColor.black.withAlphaComponent(0.93)
    static let timerStartTime = "00:00,00"
    static let tableSeparatorLineColor = UIColor(white: 1, alpha: 0.35)
    
    static let mainStopwatchId = "mainStopwatchId"
    static let cellStopwatchId = "cellStopwatchId"
    
    static let stopwatchHeightForRow: CGFloat = 44
    static let stopwatchButtonWidthHeight: CGFloat = 80
    static let stopwatchFontSize: CGFloat = 16
    static let stopwatchButtonViewWidthHeight: CGFloat = Constants.stopwatchButtonWidthHeight + 0.5
    static let stopwatchBorderConstraint: CGFloat = 20
        
    static let resetAndLapButtonDisabledBackgroundColor: UIColor = .lightGray.withAlphaComponent(0.13)
    static let resetAndLapButtonEnabledBackgroundColor: UIColor  = .lightGray.withAlphaComponent(0.4)
    
    static let stopwatchStartButtonBackgroundColor: UIColor      = .systemGreen.withAlphaComponent(0.3)
    static let stopwatchStartButtonTextColor: UIColor            = .green
    
    static let stopwatchStopButtonBackgroundColor: UIColor       = .systemRed.withAlphaComponent(0.3)

}
