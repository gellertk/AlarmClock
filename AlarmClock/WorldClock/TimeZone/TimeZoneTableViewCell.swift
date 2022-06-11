//
//  TimeZoneTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.02.2022.
//

import UIKit
import SnapKit

class TimeZoneTableViewCell: UITableViewCell {
        
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TimeZoneTableViewCell.reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(titleTextLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleTextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    public func setupData(city: String) {
        titleTextLabel.text = city
    }
    
}
