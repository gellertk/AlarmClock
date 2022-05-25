//
//  AlarmClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class CustomListCell: UICollectionViewListCell {
    
//    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }
//    private lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    
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
    
    private lazy var availabilitySwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.addTarget(self, action: #selector(didChangeAvailabilitySwitch), for: .valueChanged)
        
        return uiSwitch
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
        titleLabel.text = alarm.title
    }
    
}

private extension CustomListCell {
    
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
