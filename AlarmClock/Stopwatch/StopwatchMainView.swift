//
//  TimeAsNumbersView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 26.03.2022.
//

import UIKit
import SnapKit

class StopwatchMainView: UIView {
    
    public let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = K.String.stopwatchStartTime
        label.font = K.Font.stopwatchMainLabel
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

private extension StopwatchMainView {
    
    func setupView() {
        backgroundColor = .black
        addSubview(timeLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.leading.trailing.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
        }
    }
    
}
