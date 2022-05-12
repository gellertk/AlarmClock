//
//  AlarmSettingsTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

class ValueTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: ValueTableViewCell.reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ValueTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
    }
    
}

extension ValueTableViewCell {
    
    func configure(with options: ValueCellOption) {
        var config = UIListContentConfiguration.valueCell()
        config.text = options.text
        config.secondaryText = options.secondaryText
        config.textProperties.numberOfLines = 1
        contentConfiguration = config
        accessoryType = .disclosureIndicator
    }

}
