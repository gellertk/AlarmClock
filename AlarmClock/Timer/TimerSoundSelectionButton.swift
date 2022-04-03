//
//  TimerSoundSelectionCell.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 28.03.2022.
//

import UIKit
import SnapKit

class TimerSoundSelectionButton: UIButton {
    
    private let atEndLabel: UILabel = {
        let label = UILabel()
        label.text = "По окончании"
        label.textColor = .white
        
        return label
    }()
    
    private let soundNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Радар"
        label.textColor = .lightGray
        
        return label
    }()
    
    private let accesoryImageView: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .lightGray
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTargets()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
    
}

private extension TimerSoundSelectionButton {
    
    func setupView() {
        backgroundColor = .darkGray.withAlphaComponent(0.5)
        [atEndLabel,
         soundNameLabel,
         accesoryImageView].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        atEndLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        soundNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(accesoryImageView.snp.leading).offset(-10)
        }
        
        accesoryImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.equalTo(8)
            $0.height.equalTo(15)
        }
        
    }
    
    func setupTargets() {
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
        addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        addTarget(self, action: #selector(didDragExit), for: .touchDragExit)
    }
    
    @objc func didTap() {
        backgroundColor = .darkGray.withAlphaComponent(0.5)
    }
    
    @objc func didTouchDown() {
        backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    @objc func didDragExit() {
        backgroundColor = .darkGray.withAlphaComponent(0.5)
    }
    
}
