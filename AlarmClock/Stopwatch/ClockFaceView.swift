//
//  TimeAsStopwatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 26.03.2022.
//

import UIKit
import SnapKit

class ClockFaceView: UIView {
    
    private var secondsHandsImageView = UIImageView()
    private var minuteHandsImageView = UIImageView()
    
    private let largeClockFaceCenterCircle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
        view.backgroundColor = .black
        view.layer.borderColor = K.Color.secondaryInterface.cgColor
        view.layer.cornerRadius = view.bounds.width / 2
        view.layer.borderWidth = 2
        
        return view
    }()
    
    private let largeClockFaceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "largeClockFace")
        
        return imageView
    }()
    
    private let smallClockFaceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "smallClockFace")
        
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = K.String.stopwatchStartTime
        label.font = .monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
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
        createHands()
    }
    
    func update(_ time: TimeInterval) {
        timeLabel.text = time.convertToStopwatchFormat(timerType: .stopwatch)
    }
    
}

private extension ClockFaceView {
    
    func setupView() {
        backgroundColor = .black
        [largeClockFaceImageView,
         timeLabel,
         secondsHandsImageView,
         minuteHandsImageView].forEach {
            addSubview($0)
        }
        [largeClockFaceCenterCircle, smallClockFaceImageView].forEach {
            largeClockFaceImageView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        largeClockFaceImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(K.Numeric.trailingLeadingDefaultBorder / 2)
            $0.trailing.equalToSuperview().offset(-K.Numeric.trailingLeadingDefaultBorder / 2)
            $0.bottomMargin.topMargin.equalToSuperview()
        }
        
        smallClockFaceImageView.snp.makeConstraints {
            $0.width.height.equalTo(K.Numeric.circleButtonWidthHeight * 1.3)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-K.Numeric.circleButtonWidthHeight / 1.2)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(largeClockFaceImageView)
            $0.centerY.equalTo(largeClockFaceImageView).offset(70)
        }
        
        secondsHandsImageView.snp.makeConstraints {
            $0.edges.equalTo(largeClockFaceImageView)
        }
        
        minuteHandsImageView.snp.makeConstraints {
            $0.edges.equalTo(smallClockFaceImageView)
        }
        
        largeClockFaceCenterCircle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func createHands() {
        drawLine(onView: secondsHandsImageView,
                 from: CGPoint(x: secondsHandsImageView.bounds.width / 2, y: secondsHandsImageView.bounds.height / 1.7),
                 to: CGPoint(x: secondsHandsImageView.bounds.width / 2, y: 0),
                 colorLine: K.Color.secondaryInterface,
                 widthLine: 2)
        
        drawLine(onView: minuteHandsImageView,
                 from: CGPoint(x: minuteHandsImageView.bounds.width / 2, y: minuteHandsImageView.bounds.height / 2),
                 to: CGPoint(x: minuteHandsImageView.bounds.width / 2, y: 0),
                 colorLine: K.Color.secondaryInterface,
                 widthLine: 2)
    }
    
    func drawLine(onView: UIImageView,
                  from fromPoint: CGPoint,
                  to toPoint: CGPoint,
                  colorLine: UIColor,
                  widthLine: CGFloat) {
        
        UIGraphicsBeginImageContext(onView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        onView.image?.draw(in: onView.bounds)
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.butt)
        context.setBlendMode(.normal)
        context.setLineWidth(widthLine)
        context.setStrokeColor(colorLine.cgColor)
        context.strokePath()
        onView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}

extension ClockFaceView {
    
    func startHandsAnimation(currentSecond: TimeInterval) {
        secondsHandsImageView.layer.addStopwatchBasicAnimation(duration: 60, currentSecond: currentSecond)
        minuteHandsImageView.layer.addStopwatchBasicAnimation(duration: 60 * 60, currentSecond: currentSecond / 60)
    }
    
    func pauseHandsAnimation() {
        secondsHandsImageView.layer.pauseStopwatchAnimation()
    }
    
    func resumeHandsAnimation() {
        secondsHandsImageView.layer.resumeStopwatchAnimation()
    }
    
}
