//
//  AlarmClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class ConstrainableListCell: UICollectionViewListCell {
    
    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }
    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
        
//    private let timeLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 60, weight: .light)
//        label.adjustsFontSizeToFitWidth = true
//
//        return label
//    }()
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 15, weight: .medium)
//
//        return label
//    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(alarm: Alarm, section: Int) {
//        timeLabel.text = alarm.time.toHoursMinutes()
//        titleLabel.text = alarm.title
        var content = defaultContentConfiguration()
        content.text = alarm.time.toHoursMinutes()
        content.secondaryText = alarm.title
        content.textProperties.color = .white
        content.secondaryTextProperties.color = .white
        content.directionalLayoutMargins = .zero
        content.imageToTextPadding = 0
        contentConfiguration = content

        availabilitySwitch.isOn = alarm.isEnabled
        setupAvailability(alarm.isEnabled)
//        if section == 0 {
//            accessoryView = changeButton
//        } else {
//            accessoryView = availabilitySwitch
//        }
    }
    
}

private extension ConstrainableListCell {
    
    @objc func didChangeAvailabilitySwitch(_ sender: UISwitch) {
        setupAvailability(sender.isOn)
    }
    
    @objc func didTapChangeButton(_ sender: UISwitch) {
       
    }
    
    func setupAvailability(_ isEnabled: Bool) {
//        if isEnabled {
//            titleLabel.textColor = .white
//            timeLabel.textColor = .white
//        } else {
//            titleLabel.textColor = K.Color.disabledText
//            timeLabel.textColor = K.Color.disabledText
//        }
    }
    
    func setupView() {
        backgroundColor = .black
        [
            listContentView
        ].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        listContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
