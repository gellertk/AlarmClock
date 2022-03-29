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
    
    public weak var timerViewControllerDelegate: TimerViewControllerDelegate?
    
    public var timePickerView: TimerPickerView = {
        let pickerView = TimerPickerView()
        
        return pickerView
    }()
    
    public var circularBarView: TimerCircularBarView = {
        let view = TimerCircularBarView()
        view.isHidden = true
        
        return view
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
    
    private var soundSelectionButton: TimerSoundSelectionButton = {
        let button = TimerSoundSelectionButton()
        
        return button
    }()
    
    init(interfaceType: InterfaceType = .timerInitial) {
        super.init(frame: CGRect.zero)
        setupView(type: interfaceType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateTimerLabel(time: TimeInterval) {
        circularBarView.setupTimeLabel(time: time)
    }
    
}

private extension TimerView {
    
    func setupView(type: InterfaceType) {
        [timePickerView,
         circularBarView,
         cancelButton,
         startAndPauseButton,
         soundSelectionButton
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
        
        circularBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.topMargin.equalToSuperview().offset(10)
            $0.leading.equalTo(cancelButton)
            $0.trailing.equalTo(startAndPauseButton)
            $0.bottom.equalTo(cancelButton.snp.centerY).offset(-15)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(UIScreen.main.bounds.height * 0.46)
            $0.leading.equalToSuperview().offset( Constants.defaultBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight)
        }
        
        startAndPauseButton.snp.makeConstraints {
            $0.centerY.equalTo(cancelButton)
            $0.trailing.equalToSuperview().offset(-Constants.defaultBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight)
        }
        
        soundSelectionButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(40)
            $0.leading.equalTo(cancelButton)
            $0.trailing.equalTo(startAndPauseButton)
            $0.height.equalTo(50)
        }
        
    }
    
    func setupButtonsBy(type: InterfaceType) {
        
        switch type {
        case .timerInitial:
            cancelButton.setupBy(type: .cancelDisabled)
            startAndPauseButton.setupBy(type: .startTimer)
        case .timerRunning:
            cancelButton.setupBy(type: .cancelEnabled)
            startAndPauseButton.setupBy(type: .pause)
        case .timerPaused:
            cancelButton.setupBy(type: .cancelEnabled)
            startAndPauseButton.setupBy(type: .resume)
        default:
            break
        }
        
    }
    
}

extension TimerView: TimerViewDelegate {
    
    func didTapStartTimerButton() {
        timerViewControllerDelegate?.startTimer()
        setupButtonsBy(type: .timerRunning)
        timePickerView.isHidden = true
        circularBarView.isHidden = false
    }
    
    func didTapPauseTimerButton() {
        timerViewControllerDelegate?.stopTimer()
        setupButtonsBy(type: .timerPaused)
    }
    
    func didTapResumeTimerButton() {
        timerViewControllerDelegate?.startTimer()
        setupButtonsBy(type: .timerRunning)
    }
    
    func didTapCancelTimerButton() {
        timerViewControllerDelegate?.resetTimer()
        setupButtonsBy(type: .timerInitial)
        timePickerView.isHidden = false
        circularBarView.isHidden = true
    }
    
    func didTapDisabledCancelTimerButton() {
        setupButtonsBy(type: .timerInitial)
    }
    
}


