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
    func pauseTimer()
    func resetTimer()
    func didTimeChange()
    func resumeTimer()
    func isPaused() -> Bool
    func isRunning() -> Bool
}

class TimerViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private var timerDuration: TimeInterval {
        
        var result: TimeInterval = 0
        
        for i in 0 ..< K.Collection.numbersOfRowsAndLabelTexts.count {
            let selectedRow = timerView.timerPickerView.pickerView.selectedRow(inComponent: i)
            switch i {
            case 0:
                result += Double(selectedRow * (60 * 60))
            case 1:
                result += Double(selectedRow * 60)
            case 2:
                result += Double(selectedRow)
            default:
                break
            }
        }
        
        return result + K.Numeric.timerDelay
    }
    
    private var currentTime: TimeInterval = 0 {
        didSet {
            timerView.updateTimerLabel(time: currentTime)
        }
    }
    
    private let timer = TimerClass(type: .timer)
    
    private let timerView = TimerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegates()
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
    
    func setupDelegates() {
        timer.timerViewControllerDelegate = self
        timerView.timerViewControllerDelegate = self
        timerView.timerPickerView.delegateDataSource = self
    }
    
}

extension TimerViewController: TimerViewControllerDelegate {
    
    func isRunning() -> Bool {
        
        return timer.isRunning
    }
    
    func isPaused() -> Bool {
        
        return timer.elapsedTime != 0
    }
    
    func startTimer() {
        timer.start()
        currentTime = timerDuration
        timerView.circularBarView.timerDuration = timerDuration
        timerView.circularBarView.setupEndTimeLabel(timeLeft: timerDuration - timer.elapsedTime)
    }
    
    func pauseTimer() {
        timer.stop()
        timerView.circularBarView.setupEndTimeLabel(paused: true)
    }
    
    func resetTimer() {
        timer.reset()
    }
    
    func resumeTimer() {
        timer.start()
        timerView.circularBarView.setupEndTimeLabel(timeLeft: timerDuration - timer.elapsedTime)
    }
    
    func didTimeChange() {
        currentTime = timerDuration - timer.elapsedTime
        if currentTime <= K.Numeric.timerDelay {
            timer.reset()
            timerView.didTapCancelTimerButton()
        }
    }
    
}

extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return K.Collection.numbersOfRowsAndLabelTexts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return K.Collection.numbersOfRowsAndLabelTexts[component].key
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
        
        if timer.isRunning {
            for i in 0 ..< K.Collection.numbersOfRowsAndLabelTexts.count {
                let selectedRow = timerView.timerPickerView.pickerView.selectedRow(inComponent: i)
                pickerView.selectRow(selectedRow, inComponent: i, animated: false)
            }
        }
        
        return attributiveMainRow
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 25
    }
    
}
