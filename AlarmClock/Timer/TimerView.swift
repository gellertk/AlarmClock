//
//  TimerView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

protocol TimerViewDelegate: AnyObject {
    func didTapStartTimerButton()
    func didTapPauseTimerButton()
    func didTapResumeTimerButton()
    func didTapCancelTimerButton()
    func didTapDisabledCancelTimerButton()
}

class TimerView: UIView {
    
    public var timePickerView: TimerPickerView = {
        let pickerView = TimerPickerView()
        
        return pickerView
    }()
    
    private lazy var cancelButton: CircleButtonView = {
        let button = CircleButtonView()
        button.timerViewDelegate = self
        
        return button
    }()
    
    private lazy var startAndPauseButton: CircleButtonView = {
        let button = CircleButtonView()
        button.timerViewDelegate = self
        
        return button
    }()
    
    init(interfaceType: InterfaceType = .timerInitial) {
        super.init(frame: CGRect.zero)
        setupView(type: interfaceType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension TimerView {
    
    func setupView(type: InterfaceType) {
        [
            timePickerView,
            cancelButton,
            startAndPauseButton
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
        setupButtonsBy(type: type)
    }
    
    func setupConstraints() {
        
        timePickerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(120)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-50)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(UIScreen.main.bounds.height * 0.45)
            $0.leading.equalToSuperview().offset(Constants.defaultBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight)
        }
        
        startAndPauseButton.snp.makeConstraints {
            $0.centerY.equalTo(cancelButton)
            $0.trailing.equalToSuperview().offset(-Constants.defaultBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight)
        }
    }
    
    func setupButtonsBy(type: InterfaceType) {
        switch type {
        case .timerInitial:
            setupInitialInterface()
        case .timerRunning:
            setupRunningInterface()
        case .timerPaused:
            setupPauseInterface()
        default: break
        }
    }
    
    func setupRunningInterface() {
        cancelButton.setupBy(type: .cancelEnabled)
        startAndPauseButton.setupBy(type: .pause)
    }
    
    func setupPauseInterface() {
        cancelButton.setupBy(type: .cancelEnabled)
        startAndPauseButton.setupBy(type: .start)
    }
    
    func setupInitialInterface() {
        cancelButton.setupBy(type: .cancelDisabled)
        startAndPauseButton.setupBy(type: .start)
    }
    
}

extension TimerView: TimerViewDelegate {
    
    func didTapStartTimerButton() {
        
    }
    
    func didTapPauseTimerButton() {
        
    }
    
    func didTapResumeTimerButton() {
        
    }
    
    func didTapCancelTimerButton() {
        
    }
    
    func didTapDisabledCancelTimerButton() {
        
    }
    
}


