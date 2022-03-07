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
    static let stopWatchheightForRow: CGFloat = 44
    static let stopWatchButtonWidthHeight: CGFloat = 72
    static let stopWatchFontSize: CGFloat = 16
    static let stopWatchBackgroundCircleWidthHeight: CGFloat = Constants.stopWatchButtonWidthHeight + 3

}
