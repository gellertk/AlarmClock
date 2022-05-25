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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel(with text: String, and image: UIImage? = nil) {
        if let image = image {
            titleLabel.configure(text: text, leadingImage: image)
        } else {
            titleLabel.text = text
        }
    }
}

private extension AlarmSectionHeaderReusableView {
    
    func setupView() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.trailing.equalTo(layoutMarginsGuide)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
}
