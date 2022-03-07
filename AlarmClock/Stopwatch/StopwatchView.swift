//
//  StopWatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit
import CloudKit

protocol StopwatchViewDelegate: AnyObject {
    //func stopTimer()
    func updateTimer()
    //func
}

class StopwatchView: UIView {
    
    private lazy var stopwatch = Stopwatch(delegate: self)
    
    private static var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional // Use the appropriate positioning for the current locale
        formatter.allowedUnits = [ .hour, .minute, .second, .nanosecond] // Units to display in the formatted string
        formatter.zeroFormattingBehavior = [ .pad ] // Pad with zeroes where appropriate for the locale
        formatter.allowsFractionalUnits = true
        
        return formatter
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.timerStartTime
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        
        return label
    }()
    
    private var resetAndLapButton: UIButton = {
        let button = StopwatchButton(title: "Круг",
                                     backgroundColor: UIColor(white: 0.4, alpha: 0.6))
        button.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        return button
    }()
    
    //TODO: Code doubled
    private lazy var lapBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Constants.stopWatchBackgroundCircleWidthHeight,
                                        height: Constants.stopWatchBackgroundCircleWidthHeight))
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.6)
        
        return view
    }()
    
    //TODO: Code doubled
    private lazy var startStopBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Constants.stopWatchBackgroundCircleWidthHeight,
                                        height: Constants.stopWatchBackgroundCircleWidthHeight))
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .green
        
        return view
    }()
    
    private var startAndStopButton: UIButton = {
        let button = StopwatchButton(title: "Старт",
                                     backgroundColor: .green)
        button.addTarget(self, action: #selector(didTapStartAndStopButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var lapsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorColor = Constants.tableSeparatorLineColor
        tableView.addTableHeaderViewLine()
        tableView.register(LapTableViewCell.self, forCellReuseIdentifier: Constants.lapCellId)
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
         resetAndLapButton,
         startAndStopButton,
         lapsTableView,
         lapBackgroundView,
         startStopBackgroundView].forEach {
            
            
            addSubview($0)
        }
        sendSubviewToBack(lapBackgroundView)
        sendSubviewToBack(startStopBackgroundView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.21)
            $0.centerX.equalToSuperview()
        }
        
        resetAndLapButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(Constants.stopWatchButtonWidthHeight)
        }
        
        lapBackgroundView.snp.makeConstraints {
            $0.center.equalTo(resetAndLapButton)
            $0.width.height.equalTo(Constants.stopWatchBackgroundCircleWidthHeight)
        }
        
        startStopBackgroundView.snp.makeConstraints {
            $0.center.equalTo(startAndStopButton)
            $0.width.height.equalTo(Constants.stopWatchBackgroundCircleWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(resetAndLapButton)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(Constants.stopWatchButtonWidthHeight)
        }
        
        lapsTableView.snp.makeConstraints {
            $0.top.equalTo(resetAndLapButton.snp.bottom).offset(10)
            $0.leading.equalTo(resetAndLapButton)
            $0.trailing.equalTo(startAndStopButton)
            $0.bottomMargin.equalToSuperview()
        }
    }
    
    @objc func didTapStartAndStopButton() {
        if stopwatch.isRunning {
            stopwatch.stop()
            startAndStopButton.setTitle("Старт", for: .normal)
            startAndStopButton.backgroundColor = .green
            startStopBackgroundView.backgroundColor = .green
            resetAndLapButton.setTitle("Сброс", for: .normal)
        } else {
            stopwatch.start()
            startAndStopButton.setTitle("Стоп", for: .normal)
            startAndStopButton.backgroundColor = .red
            startStopBackgroundView.backgroundColor = .red
            resetAndLapButton.setTitle("Круг", for: .normal)
        }
    }
    
//    @objc func updateTimerLabel() {
//        timeLabel.text = elapsedTimeStr(timeInterval: stopwatch.elapsedTime)
//        //setTimeLabel(value: Int)
//    }
    
    private func elapsedTimeStr(timeInterval: TimeInterval) -> String {
        return timeInterval.stringFromTimeInterval()
    }
    
    @objc func resetTimer() {
        timeLabel.text = Constants.timerStartTime
        stopwatch.reset()
    }
    
    //func addLapTimeToTable() {
        //timeLabel.text = timer?.timeInterval.formatted()
    //}
    
    //    func setTimeLabel(_ value: Int) {
    //        let time = secondsToHoursMinutesSeconds(value)
    //        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
    //        timeLabel.text = timeString
    //    }
    //
    //    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
    //        let hour = ms / 3600
    //        let min = (ms % 3600) / 60
    //        let sec = (ms % 3600) % 60
    //        //let milSec = ()
    //        return (hour, min, sec)
    //    }
    //
    //    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
    //        var timeString = ""
    //        timeString += String(format: "%02d", hour)
    //        timeString += ":"
    //        timeString += String(format: "%02d", min)
    //        timeString += ":"
    //        timeString += String(format: "%02d", sec)
    //        return timeString
    //    }
    
}

extension StopwatchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.lapCellId) as? LapTableViewCell else {
            
            return UITableViewCell()
        }
        cell.setupData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.stopWatchheightForRow
    }
    
}

extension StopwatchView: StopwatchViewDelegate {
    
    func updateTimer() {
        timeLabel.text = elapsedTimeStr(timeInterval: stopwatch.elapsedTime)
    }
    
}
