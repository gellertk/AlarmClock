//
//  StopWatchButton.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import UIKit
import SnapKit

class CircleButtonView: UIView {
    
    private var type: CircleButtonType?
    private var action: (() -> ())?
    
    public weak var stopwatchViewDelegate: StopwatchViewDelegate?
    public weak var timerViewDelegate: TimerViewDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        
        return button
    }()
    
    init(type: CircleButtonType = .lapDisabled) {
        self.type = type
        super.init(frame: .zero)
        setupView()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(by type: CircleButtonType?) {
        guard let type = type else {
            return
        }

        self.type = type
        
        switch type {
        case .startStopwatch:
            setupAsStart()
            action = stopwatchViewDelegate?.didTapStartStopwatchButton
        case .startTimer:
            setupAsStart()
            action = timerViewDelegate?.didTapStartTimerButton
        case .stop:
            setupAsStop()
            action = stopwatchViewDelegate?.didTapStopStopwatchButton
        case .lapDisabled:
            setupDisabled()
            action = stopwatchViewDelegate?.didTapDisabledLapStopwatchButton
        case .lapEnabled:
            setupEnabled()
            action = stopwatchViewDelegate?.didTapLapStopwatchButton
        case .reset:
            setupEnabled()
            action = stopwatchViewDelegate?.didTapResetStopwatchButton
        case .cancelDisabled:
            setupDisabled()
            action = timerViewDelegate?.didTapDisabledCancelTimerButton
        case .cancelEnabled:
            setupEnabled()
            action = timerViewDelegate?.didTapCancelTimerButton
        case .pause:
            setupAsPause()
            action = timerViewDelegate?.didTapPauseTimerButton
        case .resume:
            setupAsStart()
            action = timerViewDelegate?.didTapResumeTimerButton
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        button.layer.cornerRadius = button.frame.width / 2
    }
    
}

private extension CircleButtonView {
    
    @objc func didTap() {
        performAction()
    }
    
    @objc func didTouchDown() {
        let pushedAlpha = (button.backgroundColor?.cgColor.alpha ?? 0) - K.Numeric.buttonDifferenceAlpha
        button.backgroundColor = button.backgroundColor?.withAlphaComponent(pushedAlpha)
        layer.borderColor = button.backgroundColor?.cgColor
    }
    
    @objc func didDragExit() {
        setup(by: type)
    }
    
}

private extension CircleButtonView {
    
    func setupView() {
        layer.borderWidth = 2
        addSubview(button)
        bringSubviewToFront(button)
        
        setup(by: type)
        setupConstraints()
    }

    func setupTargets() {
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(didDragExit), for: .touchDragExit)
    }
    
    func setupConstraints() {
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(K.Numeric.circleButtonWidthHeight)
        }
    }
    
    func performAction() {
        guard let action = action else {
            return
        }
        action()
    }
    
    func setupAsStart() {
        button.setTitle(type?.title ?? "", for: .normal)
        button.setTitleColor(.customSystemGreen, for: .normal)
        button.backgroundColor = .customGreen1
        layer.borderColor = UIColor.customGreen1.cgColor
    }
    
    func setupAsStop() {
        button.setTitle(type?.title ?? "", for: .normal)
        button.setTitleColor(.customRed2, for: .normal)
        button.backgroundColor = .customRed1
        layer.borderColor = UIColor.customRed1.cgColor
    }
    
    func setupAsPause() {
        button.setTitle(type?.title ?? "", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.backgroundColor = .systemOrange.withAlphaComponent(0.3)
        layer.borderColor = UIColor.systemOrange.withAlphaComponent(0.3).cgColor
    }
    
    func setupDisabled() {
        button.setTitle(type?.title ?? "", for: .normal)
        button.setTitleColor(.customWhite, for: .normal)
        button.backgroundColor = .customBlack
        layer.borderColor = UIColor.customBlack.cgColor
    }
    
    func setupEnabled() {
        button.setTitle(type?.title ?? "", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customBlack
        layer.borderColor = UIColor.customBlack.cgColor
    }
    
}
