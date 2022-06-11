//
//  WorldClockTableViewCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.02.2022.
//

import UIKit
import SnapKit

class WorldClockListCell: UICollectionViewListCell {
    
    private var currentDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня, + 0 Ч"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
        
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: .light)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(timeDifference: String,
                   city: String,
                   time: String) {
        
        currentDayLabel.text = timeDifference
        cityLabel.text = city
        timeLabel.text = time
        let customView = UICellAccessory.CustomViewConfiguration(customView: timeLabel,
                                                                 placement: .trailing(displayed: .whenNotEditing))
        accessories = [.delete(),
                       .customView(configuration: customView),
                       .reorder()]
    }
    
}

private extension WorldClockListCell {
    
    func setupView() {
        [
            currentDayLabel,
            cityLabel,
            //timeLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            currentDayLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor,
                                                           multiplier: 1),
            
            currentDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            currentDayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: cityLabel.lastBaselineAnchor,
                                                                   multiplier: 1),
            
            cityLabel.leadingAnchor.constraint(equalTo: currentDayLabel.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: currentDayLabel.trailingAnchor),
            
            cityLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: currentDayLabel.lastBaselineAnchor,
                                                     multiplier: 1),
            
            //            timeLabel.firstBaselineAnchor.constraint(equalTo: cityLabel.firstBaselineAnchor),
            //            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
            
        ])
        
    }
    
}

extension WorldClockListCell {
    
    
    
}
