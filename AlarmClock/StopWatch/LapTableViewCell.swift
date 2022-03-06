//
//  LapTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 06.03.2022.
//

import UIKit
import SnapKit

class LapTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.timeZoneCellId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private func setupView() {
        backgroundColor = Constants.timeZoneTableViewColor
        contentView.addSubview(titleTextLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            titleTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            titleTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
//        ])
    }
    
    public func setupData(city: String) {
        titleTextLabel.text = city
    }

}
