//
//  AlarmSettingsTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

class ValueCollectionViewCell: UICollectionViewListCell {
        
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
    }
    
    func configure(with options: CellData) {
        var config = UIListContentConfiguration.valueCell()
        config.text = options.text
        config.secondaryText = options.secondaryText
        config.textProperties.numberOfLines = 1
        contentConfiguration = config
        accessories = [.disclosureIndicator()]
    }
    
}
