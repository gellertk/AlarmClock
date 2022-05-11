//
//  AlarmClockTableHeaderView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 03.05.2022.
//

import UIKit

class AlarmClockSectionHeaderView: UIView {
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(section: Int) {
        let stringPart = AlarmSection.allCases[section].rawValue
        if section == 0 {
            let imagePart = NSTextAttachment(image: K.SystemImage.bed)
            let attachmentString = NSAttributedString(attachment: imagePart)
            let completeText = NSMutableAttributedString(string: "")
            completeText.append(attachmentString)
            let textAfterIcon = NSAttributedString(string: stringPart)
            completeText.append(textAfterIcon)
            sectionLabel.attributedText = completeText
        } else {
            sectionLabel.text = stringPart
        }
    }
}

private extension AlarmClockSectionHeaderView {
    
    func setupView() {
        backgroundColor = .black
        addSubview(sectionLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        sectionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        snp.makeConstraints {
//            $0.height.equalTo(20)
//        }
    }
    
}
