//
//  TimerPickerView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 27.03.2022.
//

import UIKit
import SnapKit

class TimerPickerView: UIView {
    
    public weak var delegateDataSource: TimerViewController? {
        didSet {
            timePickerView.delegate = delegateDataSource
            timePickerView.dataSource = delegateDataSource
        }
    }
    
    private lazy var timePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
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
        setupPickerViewLabels()
    }
    
}

private extension TimerPickerView {
    
    private func setupView() {
        addSubview(timePickerView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        timePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupPickerViewLabels() {
        for (index, element) in Constants.numbersOfRowsAndLabelTexts.enumerated() {
            let label = TimerPickerViewLabel(text: element.value)
            let componentWidth: CGFloat = frame.width / CGFloat(timePickerView.numberOfComponents)
            let y = (timePickerView.frame.size.height / 2) - (Constants.timerPickerViewLabelFont.pointSize / 2)
            label.frame = CGRect(x: componentWidth * (CGFloat(index) + 0.68),
                                 y: y,
                                 width: componentWidth,
                                 height: Constants.timerPickerViewLabelFont.pointSize)
            timePickerView.addSubview(label)
        }
    }
    
}
