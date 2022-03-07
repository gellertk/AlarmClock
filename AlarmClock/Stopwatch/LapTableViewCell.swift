//
//  LapTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 06.03.2022.
//

import UIKit
import SnapKit

class LapTableViewCell: UITableViewCell {
    
    private var lapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.stopWatchFontSize)
        
        return label
    }()
    
    private var timeLapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.stopWatchFontSize)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.timeZoneCellId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        isUserInteractionEnabled = false
        separatorInset = .zero
        backgroundColor = Constants.timeZoneTableViewColor
        [lapLabel, timeLapLabel].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        lapLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        timeLapLabel.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
    }
    
    public func setupData() {
        lapLabel.text = "Круг 1"
        timeLapLabel.text = "00:00,00"
        //titleTextLabel.text = city
    }

}
