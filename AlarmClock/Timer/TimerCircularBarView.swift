//
//  TimerCircularBarView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 28.03.2022.
//

import UIKit
import SnapKit

class TimerCircularBarView: UIView {
    
    public var timerDuration: TimeInterval = 0
    
    private let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 7
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeEnd = 1
        layer.lineCap = .round
        layer.strokeColor = UIColor.darkGray.cgColor
        
        return layer
    }()
    
    private let trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 7
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeEnd = 0
        layer.lineCap = .round
        layer.strokeColor = UIColor.systemOrange.cgColor
        
        return layer
    }()
    
    private var shapeView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.stopwatchStartTime
        label.font = Constants.stopwatchMainLabelFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
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
        //shapeLayer.frame = bounds
        shapeLayer.cornerRadius = frame.width / 2
        //shapeView.layer.cornerRadius = frame.width / 2
        animationCircular()
    }
    
    func setupTimeLabel(time: TimeInterval) {
        timeLabel.text = time.convertToReadableString(timerType: .timer)
    }
    
    //MARK: Animation
    func animationCircular() {
        
//        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
//        let endAngle = (-CGFloat.pi / 2)
//        let startAngle = 2 * CGFloat.pi + endAngle
        
        let diameter = min(bounds.width, bounds.height)
        let arcCenter = CGPoint(x: bounds.midX, y: bounds.midY)
                
        shapeLayer.path = UIBezierPath(arcCenter: arcCenter,
                                       radius: diameter / 2,
                                       startAngle: 0,
                                       endAngle: .pi * 2,
                                       clockwise: true).cgPath
        
        trackLayer.path = UIBezierPath(arcCenter: arcCenter,
                                       radius: diameter / 2,
                                       startAngle: .pi * 2,
                                       endAngle: 0,
                                       clockwise: true).cgPath
        
        shapeView.layer.addSublayer(shapeLayer)
        shapeView.layer.insertSublayer(trackLayer, above: shapeLayer)
    }
    
    func basicAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = timerDuration
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        trackLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
}

private extension TimerCircularBarView {
    
    func setupView() {
        backgroundColor = .black
        [shapeView,
         timeLabel
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
            $0.edges.equalToSuperview()
        }
        
    }
    
}
