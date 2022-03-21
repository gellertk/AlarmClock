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
    
    static let worldClockDefaultCities = [
       "Москва",
       "Калининград",
       "Омск",
       "Екатеринбург"
      ]
    static let timeZoneTableViewColor: UIColor = .black.withAlphaComponent(0.93)
    
    static let tabBarButtonColor: UIColor = .systemOrange

    //Stopwatch
    static let stopwatchStartTime = "00:00,00"
    static let tableSeparatorColor: UIColor  = .white.withAlphaComponent(0.2)
    static let stopwatchTableHeightForRow: CGFloat = 40
    static let defaultBorderConstraint: CGFloat = 20
    static let stopwatchMainLabelFont: UIFont = .monospacedDigitSystemFont(ofSize: 88, weight: .thin)
    static let stopwatchLapsToCustomizeCount = 3
    static let stopwatchFasterLapTextColor: UIColor = Constants.startButtonTextColor
    static let stopwatchSlowestLapTextColor: UIColor = Constants.stopButtonTextColor
    //CircleButtonView
    static let circleButtonWidthHeight: CGFloat = 80
    static let circleButtonFontSize: CGFloat = 17
    static let circleButtonViewWidthHeight: CGFloat = Constants.circleButtonWidthHeight + 4
    //pushed
    static let pushedCircleButtonDifferenceAlpha: CGFloat = 0.15
    //disabled
    static let disabledButtonTextColor: UIColor         = .white.withAlphaComponent(0.8)
    static let disabledButtonBackgroundColor: UIColor   = .lightGray.withAlphaComponent(0.25)
    //enabled
    static let enabledButtonBackgroundColor: UIColor    = .lightGray.withAlphaComponent(0.4)
    //start
    static let startButtonBackgroundColor: UIColor      = .systemGreen.withAlphaComponent(0.3)
    static let startButtonTextColor: UIColor            = .green
    //stop
    static let stopButtonBackgroundColor: UIColor       = .systemRed.withAlphaComponent(0.3)
    static let stopButtonTextColor: UIColor             = .red
    
    //cells id
    static let worldClockCellId = "worldClockCellId"
    static let timeZoneCellId = "timeZoneCellId"
    static let mainStopwatchId = "mainStopwatchId"
    static let cellStopwatchId = "cellStopwatchId"
    static let lapCellId = "lapCellId"
    
}
