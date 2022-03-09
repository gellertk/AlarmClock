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
    
    static let stopwatchHeightForRow: CGFloat = 44
    static let stopwatchButtonWidthHeight: CGFloat = 80
    static let stopwatchFontSize: CGFloat = 16
    static let stopwatchBackgroundCircleWidthHeight: CGFloat = Constants.stopwatchButtonWidthHeight + 3
    static let stopwatchBorderConstraint: CGFloat = 20
    
    static let stopwatchLapButtonDisabledBackgroundColor = UIColor.lightGray.withAlphaComponent(0.18)
    static let stopwatchLapButtonEnabledBackgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    static let stopwatchStartButtonBackgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
    static let stopwatchStopButtonBackgroundColor = UIColor.systemRed.withAlphaComponent(0.3)
    static let mainStopwatchId = "mainStopwatchId"
    static let cellStopwatchId = "cellStopwatchId"
}
