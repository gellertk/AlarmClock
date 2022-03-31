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
            pickerView.delegate = delegateDataSource
            pickerView.dataSource = delegateDataSource
        }
    }
    
    private(set) lazy var pickerView = UIPickerView()
    
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
        addSubview(pickerView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        pickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupPickerViewLabels() {
        for (index, element) in Constant.Collection.numbersOfRowsAndLabelTexts.enumerated() {
            let label = TimerPickerViewLabel(text: element.value)
            let componentWidth: CGFloat = frame.width / CGFloat(pickerView.numberOfComponents)
            let y = (pickerView.frame.size.height / 2) - (Constant.Font.timerPickerViewLabel.pointSize / 2)
            label.frame = CGRect(x: componentWidth * (CGFloat(index) + 0.68),
                                 y: y,
                                 width: componentWidth,
                                 height: Constant.Font.timerPickerViewLabel.pointSize)
            pickerView.addSubview(label)
        }
    }
    
}
