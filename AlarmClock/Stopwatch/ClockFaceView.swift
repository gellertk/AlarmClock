//
//  TimeAsStopwatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 26.03.2022.
//

import UIKit
import SnapKit

class ClockFaceView: UIView {
    
    private var handsAnimationStarted = false
    
    private let secondHandImageView = UIImageView()
    private let minuteHandImageView = UIImageView()
    
    private lazy var lapHandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        
        return imageView
    }()
    
    private let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.Image.secondsClockFace
        
        return imageView
    }()
    
    private let secondCenterCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.borderColor = UIColor.systemOrange.cgColor
        view.layer.borderWidth = 2.5
        
        return view
    }()
    
    private let minuteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.Image.minutesClockFace
        
        return imageView
    }()
    
    private let minuteCenterCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        
        return view
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
        secondCenterCircle.layer.cornerRadius = secondCenterCircle.bounds.width / 2
        minuteCenterCircle.layer.cornerRadius = minuteCenterCircle.bounds.width / 2
        createHands()
    }
    
    func update(secondsHandTime: TimeInterval, lapHandTime: TimeInterval, isRunning: Bool = false) {
        timeLabel.text = secondsHandTime.convertToFormat(by: .stopwatch)
        if !handsAnimationStarted, secondsHandTime != 0 {
            startHandsAnimation(secondsHandTime, lapHandTime)
            if !isRunning {
                pauseHandsAnimation()
            } else {
                handsAnimationStarted = true
            }
        }
    }
    
}

private extension ClockFaceView {
    
    func setupView() {
        backgroundColor = .black
        [secondImageView,
         secondCenterCircle,
         minuteImageView,
         minuteCenterCircle,
         timeLabel,
         secondHandImageView,
         minuteHandImageView,
         lapHandImageView].forEach {
            addSubview($0)
        }
        bringSubviewToFront(secondCenterCircle)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        secondImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(K.Numeric.trailingLeadingDefaultBorder / 2)
            $0.trailing.equalToSuperview().offset(-K.Numeric.trailingLeadingDefaultBorder / 2)
            $0.bottomMargin.topMargin.equalToSuperview()
        }
        
        minuteImageView.snp.makeConstraints {
            $0.width.height.equalTo(K.Numeric.circleButtonWidthHeight * 1.3)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-K.Numeric.circleButtonWidthHeight / 1.8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(secondImageView)
            $0.centerY.equalTo(secondImageView).offset(70)
        }
        
        secondHandImageView.snp.makeConstraints {
            $0.edges.equalTo(secondImageView)
        }
        
        minuteHandImageView.snp.makeConstraints {
            $0.edges.equalTo(minuteImageView)
        }
        
        secondCenterCircle.snp.makeConstraints {
            $0.center.equalTo(secondImageView)
            $0.width.height.equalTo(10)
        }
        
        minuteCenterCircle.snp.makeConstraints {
            $0.center.equalTo(minuteImageView)
            $0.width.height.equalTo(8)
        }
        
        lapHandImageView.snp.makeConstraints {
            $0.edges.equalTo(secondImageView)
        }
    }
    
    func createHands() {
        drawLine(onView: secondHandImageView,
                 from: CGPoint(x: secondHandImageView.bounds.width / 2, y: secondHandImageView.bounds.height / 1.64),
                 to: CGPoint(x: secondHandImageView.bounds.width / 2, y: 0),
                 colorLine: .systemOrange,
                 widthLine: 2.2)
        
        drawLine(onView: minuteHandImageView,
                 from: CGPoint(x: minuteHandImageView.bounds.width / 2, y: minuteHandImageView.bounds.height / 2),
                 to: CGPoint(x: minuteHandImageView.bounds.width / 2, y: 0),
                 colorLine: .systemOrange,
                 widthLine: 2.2)
        
        drawLine(onView: lapHandImageView,
                 from: CGPoint(x: lapHandImageView.bounds.width / 2, y: lapHandImageView.bounds.height / 1.64),
                 to: CGPoint(x: lapHandImageView.bounds.width / 2, y: 0),
                 colorLine: K.Color.lapHand,
                 widthLine: 2.2)
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
    
    func startLapHandAnimation() {
        lapHandImageView.layer.addStopwatchBasicAnimation(duration: 60, currentSecond: 0)
        lapHandImageView.isHidden = false
    }
    
    func startHandsAnimation(_ secondsHandTime: TimeInterval, _ lapHandTime: TimeInterval) {
        let formattedSecondsHand = secondsHandTime.truncatingRemainder(dividingBy: 60)
        let formattedLapHand = lapHandTime.truncatingRemainder(dividingBy: 60)
        secondHandImageView.layer.addStopwatchBasicAnimation(duration: 60,
                                                             currentSecond: CGFloat(formattedSecondsHand * (360 / 60)))
        minuteHandImageView.layer.addStopwatchBasicAnimation(duration: 30 * 60,
                                                             currentSecond: CGFloat(secondsHandTime / 60 * (360 / 30)))
        lapHandImageView.layer.addStopwatchBasicAnimation(duration: 60,
                                                          currentSecond: CGFloat(formattedLapHand * (360 / 60)))
        lapHandImageView.isHidden = lapHandTime == 0
    }
    
    func pauseHandsAnimation() {
        [secondHandImageView, minuteHandImageView, lapHandImageView].forEach {
            $0.layer.pauseStopwatchAnimation()
        }
    }
    
    func resumeHandsAnimation() {
        [secondHandImageView, minuteHandImageView, lapHandImageView].forEach {
            $0.layer.resumeStopwatchAnimation()
        }
    }
    
    func resetHandsAnimation() {
        [secondHandImageView, minuteHandImageView, lapHandImageView].forEach {
            $0.layer.resetStopwatchAnimation()
        }
        timeLabel.text = K.String.stopwatchStartTime
        lapHandImageView.isHidden = true
    }
    
}
