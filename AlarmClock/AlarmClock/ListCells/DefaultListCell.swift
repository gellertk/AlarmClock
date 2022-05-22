//
//  DefaultListCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 22.05.2022.
//

import UIKit

class DefaultListCell: UICollectionViewListCell {

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, secondaryText: String = "", textColor: UIColor = .white) {
        var config = UIListContentConfiguration.valueCell()
        config.text = text
        config.secondaryText = secondaryText
        config.textProperties.numberOfLines = 1
        config.textProperties.color = textColor
        contentConfiguration = config
        tintColor = .systemOrange
        layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
    }
    
}
