//
//  TimerCircularBarView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 28.03.2022.
//

import UIKit
import SnapKit

class TimerCircularBarView: UIView {
    
    private var shapeView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 7
        view.layer.borderColor = UIColor.darkGray.cgColor
        
        return view
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.stopwatchStartTime
        label.font = Constants.stopwatchMainLabelFont
        label.textAlignment = .center
        label.text = "00:00"
        
        return label
    }()

    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeView.layer.cornerRadius = frame.width / 2
    }
    
    func setupTimeLabel(time: TimeInterval) {
        timeLabel.text = time.convertToStopwatchFormatString()
    }

}

private extension TimerCircularBarView {
    
    func setupView() {
        backgroundColor = .black
        [shapeView,
         timeLabel
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        shapeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}
