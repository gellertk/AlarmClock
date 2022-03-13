//
//  StopWatchButton.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import UIKit
import SnapKit

enum StopwatchButtonType {
    case start
    case stop
    case reset
    case lapDisabled
    case lapEnabled
}

class StopwatchButton: UIView {
    
    private let type: StopwatchButtonType?
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Constants.stopwatchButtonWidthHeight,
                                        height: Constants.stopwatchButtonWidthHeight))
        button.layer.borderWidth = 2
        button.layer.cornerRadius = button.frame.width / 2

        return button
    }()
    
    init(type: StopwatchButtonType) {
        self.type = type
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: Constants.stopwatchButtonViewWidthHeight,
                                 height: Constants.stopwatchButtonViewWidthHeight))
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.borderWidth = 2
        layer.cornerRadius = frame.size.width / 2
        addSubview(button)
        bringSubviewToFront(button)
        
        setupButtons()
        setupConstraints()
        setupDefaultTargets()
    }
    
    private func setupButtons() {
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
        default:
            break
        }
    }
    
    private func setupDefaultTargets() {
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.addTarget(self, action: #selector(didPush), for: .touchDown)
        button.addTarget(self, action: #selector(didDragEnd), for: .touchDragExit)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(Constants.stopwatchButtonWidthHeight)
            $0.height.equalTo(Constants.stopwatchButtonWidthHeight)
        }
    }
    
    @objc func didTap() {
        //borderColor = UIColor.yellow.cgColor
        //secondLayer.frame = bounds
        //layer.insertSublayer(secondLayer, above: layer)
    }
    
    @objc func didPush() {
        setupButtons()
    }
    
    @objc func didDragEnd() {
        print("drageended")
        //button drag end
        //        backgroundColor = backgroundColor?.withAlphaComponent(0.3)
        //        layer.borderColor = backgroundColor?.cgColor
    }
    
    private func setupAsStartButton() {
        button.setTitle("Старт", for: .normal)
        button.setTitleColor(Constants.stopwatchStartButtonTextColor, for: .normal)
        backgroundColor = Constants.stopwatchStartButtonBackgroundColor
    }
    
    private func setupAsStopButton() {
        button.setTitle("Стоп", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        backgroundColor = Constants.stopwatchStopButtonBackgroundColor
    }
    
    private func setupAsDisabledLapButton() {
        button.setTitle("Круг", for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.6), for: .normal)
        backgroundColor = Constants.resetAndLapButtonDisabledBackgroundColor
    }
    
    private func setupAsEnabledLapButton() {
        button.setTitle("Круг", for: .normal)
        button.setTitleColor(.white, for: .normal)
        backgroundColor = Constants.resetAndLapButtonEnabledBackgroundColor
        layer.borderColor = Constants.resetAndLapButtonEnabledBackgroundColor.cgColor
    }
    
    private func setupAsResetButton() {
        button.setTitle("Сброс", for: .normal)
    }

}
