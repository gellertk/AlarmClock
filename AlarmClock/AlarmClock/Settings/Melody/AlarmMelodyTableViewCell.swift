//
//  AlarmMelodyTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

class AlarmMelodyTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AlarmMelodyTableViewCell.reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension AlarmMelodyTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
    }
    
}
