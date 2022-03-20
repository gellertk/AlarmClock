//
//  LapTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 06.03.2022.
//

import UIKit
import SnapKit

protocol LapsTableViewCellDelegate: AnyObject {
    func updateStopwatch()
}

class LapsTableViewCell: UITableViewCell {
    
    private weak var stopwatchViewDelegate: StopwatchViewDelegate?
    
    private var lapLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.circleButtonFontSize)
        
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.monospacedDigitSystemFont(ofSize: Constants.circleButtonFontSize, weight: .regular)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.timeZoneCellId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        isUserInteractionEnabled = false
        separatorInset = .zero
        backgroundColor = Constants.timeZoneTableViewColor
        [lapLabel, timeLabel].forEach {
            
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        lapLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
    }
    
    public func setup(lap: String, time: TimeInterval, textColor: UIColor) {
        lapLabel.text = "Круг \(lap)"
        timeLabel.text = time.convertToStopwatchFormatString()
        lapLabel.textColor = textColor
        timeLabel.textColor = textColor
    }
    
    public func updateStopwatch(lapTime: TimeInterval) {
        timeLabel.text = lapTime.convertToStopwatchFormatString()
    }
    
}
