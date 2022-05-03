//
//  AlarmClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class AlarmClockTableViewCell: UITableViewCell {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 40, weight: .thin)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AlarmClockTableViewCell.reuseId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent(alarm: Alarm) {
        timeLabel.text = alarm.time.convertToHoursMinutes()
    }

}

private extension AlarmClockTableViewCell {
    
    func setupView() {
        backgroundColor = .black
        addSubview(timeLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
}
