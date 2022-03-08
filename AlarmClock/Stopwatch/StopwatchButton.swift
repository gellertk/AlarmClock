//
//  StopWatchButton.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import UIKit
import SnapKit

class StopwatchButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: Constants.stopwatchButtonWidthHeight,
                                 height: Constants.stopwatchButtonWidthHeight))
        titleLabel?.font = UIFont.systemFont(ofSize: Constants.stopwatchFontSize)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.size.width / 2
    }
    
    public func setupAsStartButton() {
        setTitle("Старт", for: .normal)
        setTitleColor(.green.withAlphaComponent(0.9), for: .normal)
        backgroundColor = Constants.stopwatchStartButtonBackgroundColor
    }
    
    public func setupAsStopButton() {
        setTitle("Стоп", for: .normal)
        setTitleColor(.systemRed, for: .normal)
        backgroundColor = Constants.stopwatchStopButtonBackgroundColor
    }
    
    public func setupAsLapEnabledButton() {
        setTitle("Круг", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = Constants.stopwatchLapButtonEnabledBackgroundColor
        isEnabled = true
    }
    
    public func setupAsLapDisabledButton() {
        setTitle("Круг", for: .normal)
        setTitleColor(.white.withAlphaComponent(0.7), for: .normal)
        backgroundColor = Constants.stopwatchLapButtonDisabledBackgroundColor
        isEnabled = false
    }
    
    public func setupAsResetButton() {
        setTitle("Сброс", for: .normal)
        backgroundColor = Constants.stopwatchLapButtonEnabledBackgroundColor
    }
    
}
