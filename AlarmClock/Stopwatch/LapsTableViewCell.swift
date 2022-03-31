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
    
    private let lapLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.FontSize.circleButton)
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.monospacedDigitSystemFont(ofSize: Constant.FontSize.circleButton, weight: .regular)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constant.String.timeZoneCellId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension LapsTableViewCell {
    
    func setupView() {
        isUserInteractionEnabled = false
        separatorInset = .zero
        backgroundColor = Constant.Color.timeZoneTableView
        [lapLabel, timeLabel].forEach {
            
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        lapLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
        
    }
    
}

extension LapsTableViewCell {
    
    func setup(lap: String, time: TimeInterval, textColor: UIColor) {
        lapLabel.text = "Круг \(lap)"
        timeLabel.text = time.convertToReadableString(timerType: .stopwatch)
        lapLabel.textColor = textColor
        timeLabel.textColor = textColor
    }
    
    func updateStopwatch(lapTime: TimeInterval) {
        timeLabel.text = lapTime.convertToReadableString(timerType: .stopwatch)
    }
    
}
