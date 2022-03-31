//
//  Constants.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

struct Constant {
    
    struct Color {
        static let tableSeparator: UIColor             = .white.withAlphaComponent(0.3)
        static let secondaryInterface: UIColor         = .systemOrange
        static let fasterLapText: UIColor              = .green
        static let slowestLapText: UIColor             = .red
        static let disabledButtonText: UIColor         = .white.withAlphaComponent(0.5)
        static let disabledButtonBackground: UIColor   = .lightGray.withAlphaComponent(0.25)
        static let enabledButtonBackground: UIColor    = .lightGray.withAlphaComponent(0.4)
        static let startButtonBackground: UIColor      = .systemGreen.withAlphaComponent(0.3)
        static let startButtonText: UIColor            = .green
        static let stopButtonBackground: UIColor       = .systemRed.withAlphaComponent(0.3)
        static let stopButtonText: UIColor             = .red
        static let timeZoneTableView: UIColor          = .black.withAlphaComponent(0.93)
    }
    
    struct Collection {
        static let worldClockCities = [
            "Москва",
            "Калининград",
            "Омск",
            "Екатеринбург"
        ]
        static let numbersOfRowsAndLabelTexts: KeyValuePairs = [24: "ч",
                                                                60: "мин",
                                                                60: "с"]
    }
    
    struct String {
        static let worldClockCellId = "worldClockCellId"
        static let timeZoneCellId = "timeZoneCellId"
        static let mainStopwatchId = "mainStopwatchId"
        static let cellStopwatchId = "cellStopwatchId"
        static let lapCellId = "lapCellId"
        static let userDefaultsStopwatchKey = "stopwatch"
        static let stopwatchStartTime = "00:00,00"
    }
    
    struct Numeric {
        static let lapsToCustomizeCount = 3
        static let timeInterval = 0.01
        static let timerDelay = 0.25
        static let pushedCircleButtonDifferenceAlpha: CGFloat = 0.15
    }
    
    struct Font {
        static let stopwatchMainLabel: UIFont = .monospacedDigitSystemFont(ofSize: 88, weight: .thin)
        static let timerPickerViewLabel: UIFont = .systemFont(ofSize: 18, weight: .bold)
    }
    
    struct FontSize {
        static let circleButton: CGFloat = 17
    }
    
    struct ViewSize {
        static let trailingLeadingDefault: CGFloat = 20
        static let circleButtonTop = UIScreen.main.bounds.height * 0.46
        static let stopwatchTableHeightForRow: CGFloat = 40
        static let circleButtonWidthHeight: CGFloat = 80
        static let circleButtonViewWidthHeight: CGFloat = ViewSize.circleButtonWidthHeight + 4
    }
    
}
