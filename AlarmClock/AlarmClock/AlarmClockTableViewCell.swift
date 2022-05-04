//
//  AlarmClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class AlarmClockTableViewCell: UITableViewCell {
    
    static let reuseId: String = String(describing: AlarmClockTableViewCell.self)
        
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
        let button = UIButton()
        button.setTitle("ИЗМЕНИТЬ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(didTapChangeButton), for: .touchUpInside)
        button.backgroundColor = K.Color.changeButtonBackground
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AlarmClockTableViewCell.reuseId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent(alarm: Alarm) {
        timeLabel.text = alarm.time.toHoursMinutes()
        titleLabel.text = alarm.title
        availabilitySwitch.isOn = alarm.isEnabled
        setupAvailability(alarm.isEnabled)
        setupRightButtonVisibility(section: alarm.category)
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
    
    func setupRightButtonVisibility(section: AlarmCategory) {
        availabilitySwitch.isHidden = section == .main
        changeButton.isHidden       = section == .other
    }
    
    func setupView() {
        backgroundColor = .black
        [timeLabel,
         titleLabel,
         availabilitySwitch,
         changeButton
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
        
        availabilitySwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalTo(timeLabel.snp.centerY).offset(-10)
        }
        
        changeButton.snp.makeConstraints {
            $0.width.equalTo(109)
            $0.height.equalTo(30)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalTo(timeLabel.snp.centerY).offset(-5)
        }
    }
    
}
