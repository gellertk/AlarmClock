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
        super.init(frame: CGRect.zero)
        setupView()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupBy(type: CircleButtonType?) {
        guard let type = type else {
            return
        }

        self.type = type
        
        switch type {
        case .start:
            setupAsStopwatchStartButton()
        case .stop:
            setupAsStopwatchStopButton()
        case .lapDisabled:
            setupAsStopwatchLapDisabledButton()
        case .lapEnabled:
            setupAsStopwatchLapEnabledButton()
        case .reset:
            setupAsStopwatchResetButton()
        case .cancelDisabled:
            setupAsCancelDisabledTimerButton()
        case .cancelEnabled:
            setupAsCancelEnabledTimerButton()
        case .pause:
            setupAsPauseTimerButton()
        case .resume:
            setupAsResumeTimerButton()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        button.layer.cornerRadius = button.frame.width / 2
    }
    
}

private extension CircleButtonView {
    
    func setupView() {
        layer.borderWidth = 2
        addSubview(button)
        bringSubviewToFront(button)
        
        setupBy(type: type)
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
            $0.width.height.equalTo(Constants.circleButtonWidthHeight)
        }
    }
    
    @objc func didTap() {
        performAction()
    }
    
    @objc func didTouchDown() {
        let pushedAlpha = (button.backgroundColor?.cgColor.alpha ?? 0) - Constants.pushedCircleButtonDifferenceAlpha
        button.backgroundColor = button.backgroundColor?.withAlphaComponent(pushedAlpha)
        layer.borderColor = button.backgroundColor?.cgColor
    }
    
    @objc func didDragExit() {
        setupBy(type: type)
    }
    
    func performAction() {
        guard let action = action else {
            return
        }
        action()
    }
    
    func setupStart() {
        button.setTitle(type?.buttonTitle ?? "", for: .normal)
        button.setTitleColor(Constants.startButtonTextColor, for: .normal)
        button.backgroundColor = Constants.startButtonBackgroundColor
        layer.borderColor = Constants.startButtonBackgroundColor.cgColor
    }
    
    func setupPaused() {
        button.setTitle(type?.buttonTitle ?? "", for: .normal)
        button.setTitleColor(Constants.stopButtonTextColor, for: .normal)
        button.backgroundColor = Constants.stopButtonBackgroundColor
        layer.borderColor = Constants.stopButtonBackgroundColor.cgColor
    }
    
    func setupDisabled() {
        button.setTitle(type?.buttonTitle ?? "", for: .normal)
        button.setTitleColor(Constants.disabledButtonTextColor, for: .normal)
        button.backgroundColor = Constants.disabledButtonBackgroundColor
        layer.borderColor = Constants.disabledButtonBackgroundColor.cgColor
    }
    
    func setupEnabled() {
        button.setTitle(type?.buttonTitle ?? "", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.enabledButtonBackgroundColor
        layer.borderColor = Constants.enabledButtonBackgroundColor.cgColor
    }
    
}

//MARK: Stopwatch setup
private extension CircleButtonView {
    
    func setupAsStopwatchStartButton() {
        setupStart()
        action = stopwatchViewDelegate?.didTapStartStopwatchButton
    }
    
    func setupAsStopwatchStopButton() {
        setupPaused()
        action = stopwatchViewDelegate?.didTapStopStopwatchButton
    }
    
    func setupAsStopwatchLapDisabledButton() {
        setupDisabled()
        action = stopwatchViewDelegate?.didTapDisabledLapStopwatchButton
    }
    
    func setupAsStopwatchLapEnabledButton() {
        setupEnabled()
        action = stopwatchViewDelegate?.didTapLapStopwatchButton
    }
    
    func setupAsStopwatchResetButton() {
        button.setTitle(type?.buttonTitle ?? "", for: .normal)
        action = stopwatchViewDelegate?.didTapResetStopwatchButton
    }
    
}

//MARK: Timer setup
private extension CircleButtonView {
    
    func setupAsStartTimerButton() {
        setupStart()
        action = timerViewDelegate?.didTapStartTimerButton
    }
    
    func setupAsPauseTimerButton() {
        button.setTitle(type?.buttonTitle ?? "", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.backgroundColor = .systemOrange
        layer.borderColor = UIColor.systemOrange.cgColor
        action = timerViewDelegate?.didTapPauseTimerButton
    }
    
    func setupAsResumeTimerButton() {
        setupStart()
        action = timerViewDelegate?.didTapResumeTimerButton
    }
    
    func setupAsCancelDisabledTimerButton() {
        setupDisabled()
        action = timerViewDelegate?.didTapDisabledCancelTimerButton
    }
    
    func setupAsCancelEnabledTimerButton() {
        setupEnabled()
        action = timerViewDelegate?.didTapCancelTimerButton
    }
    
}
