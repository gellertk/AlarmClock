//
//  DefaultListCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 22.05.2022.
//

import UIKit

final class DefaultListCell: UICollectionViewListCell {

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
        config.textProperties.lineBreakMode = .byTruncatingTail
        config.secondaryTextProperties.numberOfLines = 1
        config.secondaryTextProperties.lineBreakMode = .byTruncatingTail
        config.prefersSideBySideTextAndSecondaryText = true
        config.textProperties.color = textColor
        config.axesPreservingSuperviewLayoutMargins = []

        contentConfiguration = config
        tintColor = .systemOrange
    }
    
}
