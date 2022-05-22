//
//  AlarmTitleView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit
import SnapKit

class TitleView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = K.Color.disabledBackground
        
        return scrollView
    }()
    
    private let textField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = K.Color.staticTableViewBackground
        textField.clearButtonMode = .whileEditing
        textField.becomeFirstResponder()
        textField.layer.cornerRadius = K.Numeric.defaultCornerRadius
        textField.tintColor = .systemOrange
        textField.overrideUserInterfaceStyle = .dark
        
        return textField
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setupView()
        textField.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTitle() -> String {
        guard let title = textField.text else {
            return K.String.defaultAlarmTitle
        }
        return title == "" ? K.String.defaultAlarmTitle : title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height)
    }
    
}

private extension TitleView {
    
    func setupView() {
        backgroundColor = K.Color.disabledBackground
        addSubview(scrollView)
        scrollView.addSubview(textField)
        setupConstraints()
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(self).offset(10)
            $0.trailing.equalTo(self).offset(-10)
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.width / 2)
            $0.height.equalTo(K.Numeric.defaultHeightForRow)
        }
    }
    
}
