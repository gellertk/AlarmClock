//
//  AlarmSectionHeaderReusableView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 24.05.2022.
//

import UIKit

class AlarmSectionHeaderReusableView: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: AlarmSectionHeaderReusableView.self)
    }
    
    // 2
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize,
            weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
//        label.setContentCompressionResistancePriority(
//            .defaultHigh,
//            for: .horizontal)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint( equalTo: layoutMarginsGuide.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//func set(section: Int) {
//    let stringPart = Alarm.Section.allCases[section].rawValue
//    if section == 0 {
//        let imagePart = NSTextAttachment(image: K.SystemImage.bed)
//        let attachmentString = NSAttributedString(attachment: imagePart)
//        let completeText = NSMutableAttributedString(string: "")
//        completeText.append(attachmentString)
//        let textAfterIcon = NSAttributedString(string: stringPart)
//        completeText.append(textAfterIcon)
//        sectionLabel.attributedText = completeText
//    } else {
//        sectionLabel.text = stringPart
//    }
//}
