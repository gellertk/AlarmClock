//
//  LeadingCheckmarkCollectionViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 22.05.2022.
//

import UIKit

class LeadingCheckmarkListCell: UICollectionViewListCell {
    
    var isCheckmarked: Bool = false {
        didSet {
            let checkmark = configureCheckmark()
            accessories = [.customView(configuration: checkmark)]
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String, isCheckmarked: Bool) {
        var config = UIListContentConfiguration.cell()
        config.text = text
        config.textProperties.numberOfLines = 1
        config.secondaryTextProperties.numberOfLines = 1
        contentConfiguration = config
        self.isCheckmarked = isCheckmarked
    }
    
}

private extension LeadingCheckmarkListCell {
    
    func configureCheckmark() -> UICellAccessory.CustomViewConfiguration {
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .headline)
        let image = UIImage(systemName: "checkmark", withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        var cellAccessory = UICellAccessory.CustomViewConfiguration(customView: button,
                                                                    placement: .leading(displayed: .always))
        cellAccessory.isHidden = !isCheckmarked
        cellAccessory.tintColor = .systemOrange
        
        return cellAccessory
    }
    
}
