//
//  TimerViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

protocol TimerViewControllerDelegate: AnyObject {
    func startTimer()
    func stopTimer()
    func resetTimer()
    func didTimeChange()
}

class TimerViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private lazy var timer: TimerClass = {
        let timer = TimerClass(type: .timer)
        
        return timer
    }()
    
    private var timerView: TimerView = {
        let view = TimerView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegatesAndDataSources()
    }
    
}

private extension TimerViewController {
    
    func setupView() {
        view.addSubview(timerView)
        setupConstraints()
    }
    
    func setupConstraints() {
        timerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupDelegatesAndDataSources() {
        timer.timerViewControllerDelegate = self
        timerView.timePickerView.delegateDataSource = self
    }
    
}

extension TimerViewController: TimerViewControllerDelegate {
    
    func startTimer() {
        timer.start()
        //show timer circle
    }
    
    func stopTimer() {
        timer.stop()
        //pause timer
    }
    
    func resetTimer() {
        timer.reset()
        //show picker view
    }
    
    func didTimeChange() {
        timerView.updateTimerLabel(time: timer.elapsedTime)
    }
    
}

extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return Constants.numbersOfRowsAndLabelTexts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Constants.numbersOfRowsAndLabelTexts[component].key
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        
        let leadingDigitAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        
        let attributiveMainRow = NSMutableAttributedString(string: "\(row)", attributes: attributes)
        let attributiveLeadingDigit = NSMutableAttributedString(string: "1",
                                                        attributes: leadingDigitAttributes)
        
        if String(row).count == 1 {
            attributiveMainRow.insert(attributiveLeadingDigit, at: 0)
        }
        
        return attributiveMainRow
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 25
    }
    
}
