//
//  AlarmSettingsTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

class AlarmSettingsTableViewCell: UITableViewCell {

    static let reuseId: String = String(describing: AlarmSettingsTableViewCell.self)
    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = .systemFont(ofSize: 18, weight: .regular)
//        label.adjustsFontSizeToFitWidth = true
//
//        return label
//    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Color.disabledText
        label.font = .systemFont(ofSize: 18, weight: .regular)
        
        return label
    }()
    
    private lazy var repeatedSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AlarmSettingsTableViewCell.reuseId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ alarm: Alarm, for row: Int) {
        let property = AlarmSettings.allCases[row]
        //titleLabel.text = property.rawValue
        switch property {
        case .repeating:
            valueLabel.text = alarm.getRepeatingDays()
            accessoryView = nil
            accessoryType = .disclosureIndicator
        case .title:
            valueLabel.text = alarm.title
            accessoryView = nil
            accessoryType = .disclosureIndicator
        case .ringtone:
            valueLabel.text = alarm.ringtoneId == nil ? "Нет" : "Птички поют"
            accessoryView = nil
            accessoryType = .disclosureIndicator
        case .isRepeated:
            repeatedSwitch.isOn = alarm.isRepeated
            accessoryType = .none
            accessoryView = repeatedSwitch
            selectionStyle = .none
        }
        
        valueLabel.isHidden = property == .isRepeated
        repeatedSwitch.isHidden = !(property == .isRepeated)
    }

}

private extension AlarmSettingsTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        accessoryType = .disclosureIndicator
        [
        //titleLabel,
         valueLabel
        ].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
//        titleLabel.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().offset(10)
//        }
        
        valueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-5)
        }
    }
    
}
