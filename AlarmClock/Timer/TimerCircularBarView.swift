//
//  TimerCircularBarView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 28.03.2022.
//

import UIKit
import SwiftUI
import SnapKit

class TimerCircularBarView: UIView {
    
    public var timerDuration: TimeInterval = 0
    
    private let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 7
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.darkGray.cgColor
        
        return layer
    }()
    
    private let progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 7
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.strokeColor = UIColor.systemOrange.cgColor
        
        return layer
    }()
    
    private let shapeView = UIView()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constant.String.stopwatchStartTime
        label.font = .monospacedDigitSystemFont(ofSize: 75, weight: .thin)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.enabledButtonBackground
        label.font = .systemFont(ofSize: 19, weight: .regular)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayers()
    }
    
    func setupTimeLabel(time: TimeInterval) {
        timeLabel.text = time.convertToReadableString(timerType: .timer)
    }
    
    func setupEndTimeLabel(timeLeft: TimeInterval = 0, disabled: Bool = false) {
        if disabled {
            endTimeLabel.textColor = Constant.Color.disabledButtonBackground
        } else {
            let endTime = "  \((Date() + timeLeft).convertToFormatHoursMinutes())"
            let image = UIImage(systemName: "bell.fill") ?? UIImage()
            let imageAttachment = NSTextAttachment(image: image)
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            let completeText = NSMutableAttributedString(string: "")
            completeText.append(attachmentString)
            let textAfterIcon = NSAttributedString(string: endTime)
            completeText.append(textAfterIcon)
            endTimeLabel.attributedText = completeText
            endTimeLabel.textColor = .lightGray
        }
    }
    
}

private extension TimerCircularBarView {
    
    func setupView() {
        backgroundColor = .black
        [shapeView,
         timeLabel,
         endTimeLabel
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        shapeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        endTimeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func setupLayers() {
        
        shapeLayer.cornerRadius = frame.width / 2
        
        let diameter = min(bounds.width, bounds.height)
        let arcCenter = CGPoint(x: bounds.midX, y: bounds.midY)
                
        shapeLayer.path = UIBezierPath(arcCenter: arcCenter,
                                       radius: diameter / 2,
                                       startAngle: 0,
                                       endAngle: .pi * 2,
                                       clockwise: true).cgPath
                
        progressLayer.path = UIBezierPath(arcCenter: arcCenter,
                                       radius: diameter / 2,
                                       startAngle: -.pi / 2,
                                       endAngle: .pi * 1.5,
                                       clockwise: true).cgPath
        
        shapeView.layer.addSublayer(shapeLayer)
        shapeView.layer.insertSublayer(progressLayer, above: shapeLayer)
    }
    
}

extension TimerCircularBarView {
    
    func startAnimation() {
        progressLayer.addBasicAnimation(duration: timerDuration - Constant.Numeric.timerDelay)
    }
    
    func pauseAnimation() {
        progressLayer.pauseAnimation()
    }
    
    func resumeAnimation() {
        progressLayer.resumeAnimation()
    }
    
}
