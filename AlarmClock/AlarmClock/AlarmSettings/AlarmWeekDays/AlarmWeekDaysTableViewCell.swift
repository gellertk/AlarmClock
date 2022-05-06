//
//  AlarmWeekDaysTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 05.05.2022.
//

import UIKit

class AlarmWeekDaysTableViewCell: UITableViewCell {
    
    static let reuseId: String = String(describing: AlarmWeekDaysTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AlarmWeekDaysTableViewCell.reuseId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension AlarmWeekDaysTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
    }

}
