//
//  AlarmClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class AlarmClockTableViewCell: UITableViewCell {
        
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 60, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    private lazy var availabilitySwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.addTarget(self, action: #selector(didChangeAvailabilitySwitch), for: .valueChanged)
        
        return uiSwitch
    }()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 109, height: 30))
        button.setTitle("ИЗМЕНИТЬ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(didTapChangeButton), for: .touchUpInside)
        button.backgroundColor = K.Color.changeButtonBackground
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AlarmClockTableViewCell.reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(alarm: Alarm, section: Int) {
        timeLabel.text = alarm.time.toHoursMinutes()
        titleLabel.text = alarm.title
        availabilitySwitch.isOn = alarm.isEnabled
        setupAvailability(alarm.isEnabled)
        if section == 0 {
            accessoryView = changeButton
        } else {
            accessoryView = availabilitySwitch
        }
    }
    
}

private extension AlarmClockTableViewCell {
    
    @objc func didChangeAvailabilitySwitch(_ sender: UISwitch) {
        setupAvailability(sender.isOn)
    }
    
    @objc func didTapChangeButton(_ sender: UISwitch) {
       
    }
    
    func setupAvailability(_ isEnabled: Bool) {
        if isEnabled {
            titleLabel.textColor = .white
            timeLabel.textColor = .white
        } else {
            titleLabel.textColor = K.Color.disabledText
            timeLabel.textColor = K.Color.disabledText
        }
    }
    
    func setupView() {
        backgroundColor = .black
        [timeLabel,
         titleLabel
        ].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top)
        }
    }
    
}
