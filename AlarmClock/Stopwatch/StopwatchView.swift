//
//  StopWatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

protocol StopwatchViewDelegate: AnyObject {
    func updateTimer()
}

class StopwatchView: UIView {
    
    private var lapTimes: [TimeInterval] = []
    private var cellStopwatchElapsedTime: Double {
        if lapTimes.count > 1 {
            return (stopwatch.roundedElapsedTime - lapTimes.reduce(0, +) + lapTimes[lapTimes.count - 1]).rounded(to: 2)
        }
        return stopwatch.roundedElapsedTime
    }
    
    private lazy var stopwatch = Stopwatch(stopwatchViewDelegate: self)
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.timerStartTime
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 88, weight: .thin)
        
        return label
    }()
    
    private var lapAndResetButton: StopwatchButtonView = {
        let button = StopwatchButtonView(type: .lapDisabled)
//        button.addTarget(self, action: #selector(didTapLapAndResetButton), for: .touchUpInside)
//        let button = UIButton()
        
        return button
    }()
    
    private var startAndStopButton: StopwatchButtonView = {
        
        return StopwatchButtonView(type: .start)
    }()
    
    private lazy var lapsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorColor = Constants.tableSeparatorLineColor
        tableView.addTableHeaderViewLine()
        tableView.register(LapsTableViewCell.self, forCellReuseIdentifier: Constants.lapCellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [timeLabel,
         lapAndResetButton,
         startAndStopButton,
         lapsTableView,].forEach {
            
            addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.21)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.stopwatchBorderConstraint)
            $0.trailing.equalToSuperview().offset(-Constants.stopwatchBorderConstraint)
        }
        
        lapAndResetButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.stopwatchBorderConstraint)
            $0.width.height.equalTo(Constants.stopwatchButtonViewWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(lapAndResetButton)
            $0.trailing.equalToSuperview().offset(-Constants.stopwatchBorderConstraint)
            $0.width.height.equalTo(Constants.stopwatchButtonViewWidthHeight)
        }
        
        lapsTableView.snp.makeConstraints {
            $0.top.equalTo(lapAndResetButton.snp.bottom).offset(10)
            $0.leading.equalTo(lapAndResetButton)
            $0.trailing.equalTo(startAndStopButton)
            $0.bottomMargin.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lapAndResetButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.stopwatchBorderConstraint)
            $0.width.height.equalTo(Constants.stopwatchButtonViewWidthHeight)
        }
    }
    
    @objc func didTapStartAndStopButton() {
        if stopwatch.isRunning {
            stopTimer()
        } else {
            startTimer()
        }
        //setupButtons()
    }
    
    @objc func didTapLapAndResetButton() {
        if stopwatch.isRunning {
            addLap()
        } else {
            resetTimer()
        }
        //setupButtons()
    }
    
//    @objc func didPushStartAndStopButton() {
//        startAndStopButton.backgroundColor = startAndStopButton.backgroundColor?.withAlphaComponent(0.05)
//        startAndStopBackgroundView.layer.borderColor = startAndStopButton.backgroundColor?.withAlphaComponent(0.05).cgColor
//    }
    
    @objc func didCancelPushStartAndStopButton() {
        //setupButtons()
    }
    
    private func startTimer() {
        stopwatch.start()
        if lapTimes.isEmpty {
            addLap()
        }
    }
    
    private func stopTimer() {
        stopwatch.stop()
        lapTimes[lapTimes.count - 1] = cellStopwatchElapsedTime
    }
    
    private func resetTimer() {
        timeLabel.text = Constants.timerStartTime
        stopwatch.reset()
        lapTimes.removeAll()
        lapsTableView.reloadData()
    }
    
    private func addLap() {
        if !lapTimes.isEmpty {
            lapTimes[lapTimes.count - 1] = cellStopwatchElapsedTime
        }
        lapTimes.append(0.0)
        lapsTableView.reloadData()
    }
    
//    private func setupButtons() {
//        if lapTimes.isEmpty {
//            setupDisabledLapButton()
//            setupStartButton()
//
//        } else if stopwatch.isRunning {
//            setupLapEnabledButton()
//            setupStopButton()
//
//        } else {
//            setupResetButton()
//            setupStartButton()
//        }
//    }
    
//    private func setupStartButton() {
//        startAndStopButton.setupAsStartButton()
//        startAndStopBackgroundView.layer.borderColor = Constants.stopwatchStartButtonBackgroundColor.cgColor
//    }
//
//    private func setupStopButton() {
//        startAndStopButton.setupAsStopButton()
//        startAndStopBackgroundView.layer.borderColor = Constants.stopwatchStopButtonBackgroundColor.cgColor
//    }
//
//    private func setupResetButton() {
//        lapAndResetButton.setupAsResetButton()
//    }
//
//    private func setupLapEnabledButton() {
//        lapAndResetButton.setupAsLapEnabledButton()
//        //lapAndResetBackgroundView.layer.borderColor = Constants.stopwatchLapButtonEnabledBackgroundColor.cgColor
//    }
//
//    private func setupDisabledLapButton() {
//        lapAndResetButton.setupAsLapDisabledButton()
//        //lapAndResetBackgroundView.layer.borderColor = Constants.stopwatchLapButtonDisabledBackgroundColor.cgColor
//    }
    
}

extension StopwatchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.lapCellId) as? LapsTableViewCell else {
            
            return UITableViewCell()
        }
        cell.setup(lap: String(lapTimes.count - indexPath.row),
                   time: lapTimes.reversed()[indexPath.row].stringFromTimeInterval())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.stopwatchHeightForRow
    }
    
}

extension StopwatchView: StopwatchViewDelegate, LapsTableViewCellDelegate {
    
    func updateTimer() {
        timeLabel.text = stopwatch.roundedElapsedTime.stringFromTimeInterval()
        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
//            var cellElapsedTime = cellStopwatchElapsedTime.minuteSecondMs
//            if lapTimes.count > 1 {
//                cellElapsedTime = (ceil(cellStopwatchElapsedTime * 100) / 100.0).minuteSecondMs
//            }
            cell.setup(lap: String(lapTimes.count), time: cellStopwatchElapsedTime.stringFromTimeInterval())
        }
    }
    
}
