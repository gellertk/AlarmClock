//
//  Constants.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

enum CircleButtonType {
    case start
    case stop
    case reset
    case lapDisabled
    case lapEnabled
}

enum InterfaceType {
    case stopwatchInitial
    case stopwatchRunning
    case stopwatchPause
}

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
    static let circleButtonViewWidthHeight: CGFloat = Constants.circleButtonWidthHeight + 4
    static let standartBorderConstraint: CGFloat = 20
    
    static let pushedDifferenceAlpha: CGFloat = 0.15
    
    static let disabledButtonTextColor: UIColor = .white.withAlphaComponent(0.8)
    static let disabledButtonBackgroundColor: UIColor = .lightGray.withAlphaComponent(0.25)
    
    static let enabledButtonBackgroundColor: UIColor  = .lightGray.withAlphaComponent(0.4)
    
    static let startButtonBackgroundColor: UIColor      = .systemGreen.withAlphaComponent(0.3)
    static let startButtonTextColor: UIColor            = .green
    
    static let stopButtonBackgroundColor: UIColor       = .systemRed.withAlphaComponent(0.3)
    static let stopButtonTextColor: UIColor           = .red
    
    static let stopwatchMainLabelFont: UIFont = .monospacedDigitSystemFont(ofSize: 88, weight: .thin)
    
}
