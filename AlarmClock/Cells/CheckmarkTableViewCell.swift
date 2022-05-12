//
//  CheckmarkTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 12.05.2022.
//

import UIKit

class CheckmarkTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: ValueTableViewCell.reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with options: CheckmarkCellOption) {
        var config = defaultContentConfiguration()
        config.text = options.text
        contentConfiguration = config
        accessoryType = options.isCheckmarked ? .checkmark : .none
    }
    
    func toggleCheckmark() {
        accessoryType = accessoryType == .none ? .checkmark : .none
    }

}

private extension CheckmarkTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
    }
    
}
