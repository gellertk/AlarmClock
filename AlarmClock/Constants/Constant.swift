//
//  Constants.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

struct K {
    
    struct Color {
        static let tableSeparator: UIColor             = .init(red: 51, green: 51, blue: 54)
        static let lapHand: UIColor                    = .init(red: 8, green: 120, blue: 247)
        static let fasterLapText: UIColor              = .init(red: 70, green: 198, blue: 107)
        static let slowestLapText: UIColor             = .init(red: 221, green: 84, blue: 83)
        static let disabledButtonText: UIColor         = .init(red: 160, green: 159, blue: 164)
        static let enabledButtonBackground: UIColor    = .init(red: 51, green: 51, blue: 51)
        static let startButtonBackground: UIColor      = .init(red: 9, green: 41, blue: 18)
        static let startButtonText: UIColor            = .init(red: 76, green: 205, blue: 107)
        static let stopButtonBackground: UIColor       = .init(red: 52, green: 14, blue: 11)
        static let stopButtonText: UIColor             = .init(red: 235, green: 89, blue: 84)
        static let disabledText: UIColor               = .init(red: 143, green: 142, blue: 150)
        static let changeButtonBackground: UIColor     = .init(red: 38, green: 38, blue: 41)
        static let disabledBackground: UIColor         = .init(red: 28, green: 28, blue: 30)
        static let staticTableViewBackground: UIColor  = .init(red: 44, green: 44, blue: 47)
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
        static let defaultAlarmTitle = "Будильник"
    }
    
    struct Numeric {
        static let timeInterval = 0.01
        static let timerDelay = 0.25
        static let lapsToCustomizeCount = 3
        static let buttonDifferenceAlpha: CGFloat = 0.3
        static let circleButtonFontSize: CGFloat = 17
        static let trailingLeadingDefaultBorder: CGFloat = 20
        static let circleButtonTop = UIScreen.main.bounds.height * 0.46
        static let defaultHeightForRow: CGFloat = 45
        static let circleButtonWidthHeight: CGFloat = 80
        static let circleButtonViewWidthHeight: CGFloat = Numeric.circleButtonWidthHeight + 4
        static let defaultCornerRadius: CGFloat = 10
    }
    
    struct Font {
        static let stopwatchMainLabel: UIFont = .monospacedDigitSystemFont(ofSize: 88, weight: .thin)
        static let timerPickerViewLabel: UIFont = .systemFont(ofSize: 18, weight: .bold)
    }
    
    struct SystemImage {
        static let bell = UIImage(systemName: "bell.fill") ?? UIImage()
        static let worldClock = UIImage(systemName: "globe") ?? UIImage()
        static let alarmClock = UIImage(systemName: "alarm.fill") ?? UIImage()
        static let stopwatch = UIImage(systemName: "stopwatch.fill") ?? UIImage()
        static let timer = UIImage(systemName: "timer") ?? UIImage()
        static let plus = UIImage(systemName: "plus") ?? UIImage()
        static let chevronRight = UIImage(systemName: "chevron.right") ?? UIImage()
        static let bed = UIImage(systemName: "bed.double.fill") ?? UIImage()
    }
    
    struct Image {
        static let secondsClockFace = UIImage(named: "secondsClockFace")
        static let minutesClockFace = UIImage(named: "minutesClockFace")
    }

}
