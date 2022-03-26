//
//  TimeAsNumbersView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 26.03.2022.
//

import UIKit
import SnapKit

class StopwatchNumbersView: UIView {
    
    public var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.stopwatchStartTime
        label.font = Constants.stopwatchMainLabelFont
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
    
    private func setupView() {
        backgroundColor = .black
        addSubview(timeLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.left.right.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(Constants.defaultBorderConstraint)
        }
    }
    
}
