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
        label.textColor = .lightGray
        
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 55, weight: .light)
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

    private func setupView() {
        backgroundColor = .black
        [currentDayLabel, cityLabel, timeLabel].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {

        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.trailing.equalToSuperview().offset(-20)
        }
        
        currentDayLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel).offset(-3)
            $0.leading.equalToSuperview().offset(20)
        }
        
        cityLabel.snp.makeConstraints {
            $0.bottom.equalTo(timeLabel).offset(3)
            $0.leading.equalTo(currentDayLabel)
        }
        
    }
    
    public func setupData(_ worldClock: WorldClock) {
        cityLabel.text = worldClock.city
        timeLabel.text = worldClock.time
    }

}
