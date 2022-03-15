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
    static let stopwatchStartTime = "00:00,00"
    static let tableSeparatorLineColor = UIColor(white: 1, alpha: 0.35)
    
    static let mainStopwatchId = "mainStopwatchId"
    static let cellStopwatchId = "cellStopwatchId"
    
    static let stopwatchTableHeightForRow: CGFloat = 44
    static let circleButtonWidthHeight: CGFloat = 80
    static let circleButtonFontSize: CGFloat = 16
    static let circleButtonViewWidthHeight: CGFloat = Constants.circleButtonWidthHeight + 3
    static let standartBorderConstraint: CGFloat = 20
    
    static let disabledButtonTextColor: UIColor = .white.withAlphaComponent(0.3)
    static let disabledButtonBackgroundColor: UIColor = .lightGray.withAlphaComponent(0.13)
    static let disabledPushedButtonBackgroundColor: UIColor = .lightGray.withAlphaComponent(0.03)
    
    static let enabledButtonBackgroundColor: UIColor  = .lightGray.withAlphaComponent(0.4)
    
    static let startButtonBackgroundColor: UIColor      = .systemGreen.withAlphaComponent(0.3)
    static let startButtonTextColor: UIColor            = .green
    
    static let stopButtonBackgroundColor: UIColor       = .systemRed.withAlphaComponent(0.3)
    static let stopButtonTextColor: UIColor           = .red

}
