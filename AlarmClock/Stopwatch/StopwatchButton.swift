//
//  StopWatchButton.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import UIKit
import SnapKit

class StopWatchButton: UIButton {
    
//    private lazy var backgroundCircleView: UIView = {
//        let view = UIView(frame: CGRect(x: 0,
//                                        y: 0,
//                                        width: Constants.stopWatchButtonHeight + 3,
//                                        height: Constants.stopWatchButtonWidth + 3))
//        view.layer.cornerRadius = view.frame.width / 2
//        view.backgroundColor = .lightGray
//
//        return view
//    }()
    
    convenience init(title: String,
                     backgroundColor: UIColor) {
        
        self.init(frame: CGRect(x: 0,
                                y: 0,
                                width: Constants.stopWatchButtonWidthHeight,
                                height: Constants.stopWatchButtonWidthHeight))
        self.backgroundColor = backgroundColor
        //isEnabled = false
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: Constants.stopWatchFontSize)
        setupView()
    }
    
    private func setupView() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.size.width / 2
       // addSubview(backgroundCircleView)
    }
    
//    private func setupConstraints() {
//        backgroundCircleView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.width.equalTo(Constants.stopWatchButtonHeight + 3)
//            $0.height.equalTo(Constants.stopWatchButtonWidth + 3)
//        }
//    }
    
}
