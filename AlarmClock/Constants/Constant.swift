//
//  Constants.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

struct K {
    
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
        static let footerForShopSection = "При этом будут загружены все рингтоны и предупреждения, купленные с помощью учетной записи " + userEmail + "."
        static let userEmail = "gerry9@bk.ru"
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
    
    struct Image {
        static let secondsClockFace = UIImage(named: "secondsClockFace")
        static let minutesClockFace = UIImage(named: "minutesClockFace")
    }
    
}
