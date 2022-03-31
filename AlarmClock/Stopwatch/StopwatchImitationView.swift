//
//  TimeAsStopwatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 26.03.2022.
//

import UIKit
import SnapKit

class StopwatchImitationView: UIView {

    public let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constant.String.stopwatchStartTime
        label.font = .monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension StopwatchImitationView {
    
    func setupView() {
        backgroundColor = .black
        addSubview(timeLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.left.right.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
        }
    }
    
}
