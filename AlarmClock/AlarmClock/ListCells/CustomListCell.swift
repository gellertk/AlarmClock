//
//  AlarmClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class CustomListCell: UICollectionViewListCell {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 62, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var _switch: UISwitch = {
        let _switch = UISwitch()
        _switch.addTarget(self, action: #selector(didChangeAvailabilitySwitch), for: .valueChanged)
        
        return _switch
    }()
    
    lazy var changeButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .capsule
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemOrange,
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
        ]
        configuration.attributedTitle = AttributedString("ИЗМЕНИТЬ", attributes: AttributeContainer(attributes))
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with alarm: Alarm) {
        timeLabel.text = alarm.time.toHoursMinutes()
        titleLabel.text = "\(alarm.title), \(alarm.weekDays.toWeekDaysFormat(forAlarmList: true))"
        if alarm.isMainAlarm {
            let customView = UICellAccessory.CustomViewConfiguration(customView: changeButton,
                                                                     placement: .trailing())
            accessories = [.customView(configuration: customView)]
        } else {
            _switch.isOn = alarm.isEnabled
            let customView = UICellAccessory.CustomViewConfiguration(customView: _switch,
                                                                     placement: .trailing(displayed: .whenNotEditing))
            accessories = [.delete(),
                                .customView(configuration: customView),
                                .disclosureIndicator(displayed: .whenEditing, options: .init())]
            setupAvailability(alarm.isEnabled)
        }
        
    }
    
}

private extension CustomListCell {
    
    @objc func didChangeAvailabilitySwitch(_ sender: UISwitch) {
        setupAvailability(sender.isOn)
    }
    
    @objc func didTapChangeButton(_ sender: UISwitch) {
        
    }
    
    func setupAvailability(_ isEnabled: Bool) {
        titleLabel.textColor = isEnabled ? .white : K.Color.disabledText
        timeLabel.textColor = isEnabled ? .white : K.Color.disabledText
    }
    
    func setupView() {
        backgroundView = UIView()
        [
            timeLabel,
            titleLabel,
            
        ].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(contentView).offset(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(timeLabel.snp.bottom)
            $0.bottom.equalTo(contentView).offset(-10)
        }
        
    }
    
}
