//
//  WorldClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.02.2022.
//

import UIKit
import SnapKit

class WorldClockTableViewCell: UITableViewCell {
    
    static let reuseId = "WorldClockTableViewCell"
        
    private var currentDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня, + 0 Ч"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = K.Color.disabledText
        
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: WorldClockTableViewCell.reuseId)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(_ worldClock: WorldClock) {
        cityLabel.text = worldClock.city
        timeLabel.text = worldClock.time
    }
    
}

private extension WorldClockTableViewCell {
    
    func setupView() {
        backgroundColor = .black
        [currentDayLabel, cityLabel, timeLabel].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {

        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        currentDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeLabel).offset(-15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        cityLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeLabel).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
    }
    
}
