//
//  Constants.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

struct K {
    
    struct Color {

        static let tableSeparator: UIColor             = .init(red: 50, green: 50, blue: 50)
        static let secondaryInterface: UIColor         = .systemOrange
        static let fasterLapText: UIColor              = .init(red: 70, green: 198, blue: 107)
        static let slowestLapText: UIColor             = .init(red: 221, green: 84, blue: 83)
        static let disabledButtonText: UIColor         = .init(red: 160, green: 159, blue: 164)
        static let disabledButtonBackground: UIColor   = .init(red: 28, green: 28, blue: 30)
        static let enabledButtonBackground: UIColor    = .init(red: 51, green: 51, blue: 51)
        static let startButtonBackground: UIColor      = .init(red: 9, green: 41, blue: 18)
        static let startButtonText: UIColor            = .init(red: 76, green: 205, blue: 107)
        static let stopButtonBackground: UIColor       = .init(red: 52, green: 14, blue: 11)
        static let stopButtonText: UIColor             = .init(red: 235, green: 89, blue: 84)
        static let timeZoneTableView: UIColor          = .black
        
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
        static let userDefaultsStopwatchKey = "stopwatch"
        static let stopwatchStartTime = "00:00,00"
    }
    
    struct Numeric {
        static let timeInterval = 0.01
        static let timerDelay = 0.25
        static let lapsToCustomizeCount = 3
        static let buttonDifferenceAlpha: CGFloat = 0.3
        static let circleButtonFontSize: CGFloat = 17
        static let trailingLeadingDefaultBorder: CGFloat = 20
        static let circleButtonTop = UIScreen.main.bounds.height * 0.46
        static let stopwatchTableHeightForRow: CGFloat = 45
        static let circleButtonWidthHeight: CGFloat = 80
        static let circleButtonViewWidthHeight: CGFloat = Numeric.circleButtonWidthHeight + 4
    }
    
    struct Font {
        static let stopwatchMainLabel: UIFont = .monospacedDigitSystemFont(ofSize: 88, weight: .thin)
        static let timerPickerViewLabel: UIFont = .systemFont(ofSize: 18, weight: .bold)
    }
    
}
