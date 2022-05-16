//
//  LeftCheckmarkTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 13.05.2022.
//

import UIKit

class LeftCheckmarkTableViewCell: UITableViewCell {
    
    lazy var config = defaultContentConfiguration()
    
    private let checkmarkImage: UIImage = {
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 13, weight: .bold)
        
        return UIImage(systemName: "checkmark", withConfiguration: smallConfiguration) ?? UIImage()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: "")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with options: CheckmarkCellOption) {
        config.text = options.text
        config.textProperties.numberOfLines = 1
        //config.image = checkmarkImage
        contentConfiguration = config
        setLeftCheckmark(options.isCheckmarked)
    }
    
    func setLeftCheckmark(_ isCheckmarked: Bool) {
//        if isCheckmarked {
//            config.imageProperties.tintColor = .systemOrange
//        } else {
//            config.imageProperties.tintColor = backgroundColor
//        }
//        contentConfiguration = config
    }

}

private extension LeftCheckmarkTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
    }
    
}
