//
//  TimerPickerViewLabel.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 27.03.2022.
//

import UIKit

class TimerPickerViewLabel: UILabel {
    
    init(text: String) {
        super.init(frame: CGRect.zero)
        self.text = text
        setupView()
    }
    
    private func setupView() {
        font = Constants.timerPickerViewLabelFont
        textColor = .white
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
