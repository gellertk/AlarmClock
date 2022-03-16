//
//  StopWatchButton.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import UIKit
import SnapKit

class CircleButtonView: UIView {
    
    private let type: CircleButtonType?
    private var action: (() -> ())?
    
    public weak var stopwatchViewDelegate: StopwatchViewDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        
        return button
    }()
    
    init(type: CircleButtonType, delegate: StopwatchViewDelegate) {
        self.type = type
        self.stopwatchViewDelegate = delegate
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.borderWidth = 2
        addSubview(button)
        bringSubviewToFront(button)
        
        setupBy(type: type)
        setupConstraints()
        setupTargets()
    }
    
    public func setupBy(type: CircleButtonType?) {
        switch type {
        case .start:
            setupAsStartButton()
        case .stop:
            setupAsStopButton()
        case .lapDisabled:
            setupAsDisabledLapButton()
        case .lapEnabled:
            setupAsEnabledLapButton()
        case .reset:
            setupAsResetButton()
        case .none:
            break
        }
    }
    
    private func setupTargets() {
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.addTarget(self, action: #selector(didPush), for: .touchDown)
        button.addTarget(self, action: #selector(didDragExit), for: .touchDragExit)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(Constants.circleButtonWidthHeight)
        }
    }
    
    @objc func didTap() {
        performAction()
    }
    
    @objc func didPush() {
        let pushedAlpha = (button.backgroundColor?.cgColor.alpha ?? 0) - Constants.pushedDifferenceAlpha
        button.backgroundColor = button.backgroundColor?.withAlphaComponent(pushedAlpha)
        layer.borderColor = button.backgroundColor?.cgColor
    }
    
    @objc func didDragExit() {
        setupBy(type: type)
    }
    
    private func performAction() {
        guard let action = action else {
            return
        }
        action()
    }
    
    private func setupAsStartButton() {
        button.setTitle("Старт", for: .normal)
        button.setTitleColor(Constants.startButtonTextColor, for: .normal)
        button.backgroundColor = Constants.startButtonBackgroundColor
        layer.borderColor = Constants.startButtonBackgroundColor.cgColor
        action = stopwatchViewDelegate?.didTapStartStopwatchButton
    }
    
    private func setupAsStopButton() {
        button.setTitle("Стоп", for: .normal)
        button.setTitleColor(Constants.stopButtonTextColor, for: .normal)
        button.backgroundColor = Constants.stopButtonBackgroundColor
        layer.borderColor = Constants.stopButtonBackgroundColor.cgColor
        action = stopwatchViewDelegate?.didTapStopStopwatchButton
    }
    
    private func setupAsDisabledLapButton() {
        button.setTitle("Круг", for: .normal)
        button.setTitleColor(Constants.disabledButtonTextColor, for: .normal)
        button.backgroundColor = Constants.disabledButtonBackgroundColor
        layer.borderColor = Constants.disabledButtonBackgroundColor.cgColor
        action = stopwatchViewDelegate?.didTapDisabledLapStopwatchButton
    }
    
    private func setupAsEnabledLapButton() {
        button.setTitle("Круг", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.enabledButtonBackgroundColor
        layer.borderColor = Constants.enabledButtonBackgroundColor.cgColor
        action = stopwatchViewDelegate?.didTapLapStopwatchButton
    }
    
    private func setupAsResetButton() {
        button.setTitle("Сброс", for: .normal)
        action = stopwatchViewDelegate?.didTapResetStopwatchButton
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
        button.layer.cornerRadius = button.frame.width / 2
    }
    
}
