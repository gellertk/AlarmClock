//
//  WorldClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.02.2022.
//

import UIKit

class WorldClockTableViewCell: UITableViewCell {
        
    private lazy var currentDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня, + 0 Ч"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 55, weight: .light)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.cellId)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .black
        [currentDayLabel, cityLabel, timeLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            currentDayLabel.bottomAnchor.constraint(equalTo: timeLabel.centerYAnchor, constant: -5),
            currentDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            cityLabel.topAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    public func setupData(_ worldClock: WorldClock) {
        //currentDayLabel.text = "Сегодня, +0 Ч"
        cityLabel.text = worldClock.city
        timeLabel.text = worldClock.time
    }

}
