//
//  DefaultTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 12.05.2022.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: DefaultTableViewCell.reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DefaultTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
    }
    
}

extension DefaultTableViewCell {
    
    func configure(with options: DefaultCellOption) {
        var config = UIListContentConfiguration.valueCell()
        config.text = options.text
        config.textProperties.color = options.textColor
        config.textProperties.numberOfLines = 1
        contentConfiguration = config
    }

}
