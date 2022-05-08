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
    
    weak var timerViewControllerDelegate: TimerViewControllerDelegate?
    
    private(set) var timerPickerView = TimerPickerView()
    
    public let circularBarView: TimerCircularBarView = {
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
    
    private let soundSelectionButton = TimerSoundSelectionButton()
    
    init(interfaceType: InterfaceType = .timerInitial) {
        super.init(frame: .zero)
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
        [timerPickerView,
         circularBarView,
         cancelButton,
         startAndPauseButton,
         soundSelectionButton
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
        setupButtons(by: type)
    }
    
    func setupConstraints() {
        
        //TODO: Fix centering
        timerPickerView.snp.makeConstraints {
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
            $0.top.equalTo(K.Numeric.circleButtonTop)
            $0.leading.equalToSuperview().offset(K.Numeric.trailingLeadingDefaultBorder)
            $0.width.height.equalTo(K.Numeric.circleButtonViewWidthHeight)
        }
        
        startAndPauseButton.snp.makeConstraints {
            $0.centerY.equalTo(cancelButton)
            $0.trailing.equalToSuperview().offset(-K.Numeric.trailingLeadingDefaultBorder)
            $0.width.height.equalTo(K.Numeric.circleButtonViewWidthHeight)
        }
        
        soundSelectionButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(40)
            $0.leading.equalTo(cancelButton)
            $0.trailing.equalTo(startAndPauseButton)
            $0.height.equalTo(50)
        }
        
    }
    
    func setupButtons(by type: InterfaceType) {
        
        switch type {
        case .timerInitial:
            cancelButton.setup(by: .cancelDisabled)
            startAndPauseButton.setup(by: .startTimer)
        case .timerRunning:
            cancelButton.setup(by: .cancelEnabled)
            startAndPauseButton.setup(by: .pause)
        case .timerPaused:
            cancelButton.setup(by: .cancelEnabled)
            startAndPauseButton.setup(by: .resume)
        default:
            break
        }
        
    }
    
}

extension TimerView: TimerViewDelegate {
    
    func didTapStartTimerButton() {
        timerViewControllerDelegate?.startTimer()
        setupButtons(by: .timerRunning)
        timerPickerView.isHidden = true
        circularBarView.isHidden = false
        circularBarView.startAnimation()
    }
    
    func didTapPauseTimerButton() {
        timerViewControllerDelegate?.pauseTimer()
        setupButtons(by: .timerPaused)
        circularBarView.pauseAnimation()
    }
    
    func didTapResumeTimerButton() {
        timerViewControllerDelegate?.resumeTimer()
        setupButtons(by: .timerRunning)
        circularBarView.resumeAnimation()
    }
    
    func didTapCancelTimerButton() {
        timerViewControllerDelegate?.resetTimer()
        setupButtons(by: .timerInitial)
        timerPickerView.isHidden = false
        circularBarView.isHidden = true
    }
    
    func didTapDisabledCancelTimerButton() {
        setupButtons(by: .timerInitial)
    }
    
}


