//
//  TitleSupplementaryView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.05.2022.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    static let reuseIdentifier = "TitleSupplementaryView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    
    func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
        label.font = UIFont.preferredFont(forTextStyle: .title3)
    }
    
}
