//
//  StopWatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

class StopWatchView: UIView {
    
    private var timer: Timer?
    private var isTimerRunnig: Bool = false
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.timerStartTime
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        
        return label
    }()
    
    private var lapAndResetButton: UIButton = {
        let button = StopWatchButton(title: "Круг",
                                     backgroundColor: UIColor(white: 0.4, alpha: 0.6))
        
        return button
    }()
    
    //TODO: Code doubled
    private lazy var lapBackgroundCircleView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Constants.stopWatchBackgroundCircleWidthHeight,
                                        height: Constants.stopWatchBackgroundCircleWidthHeight))
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.6)

        return view
    }()
    
    //TODO: Code doubled
    private lazy var startStopBackgroundCircleView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Constants.stopWatchBackgroundCircleWidthHeight,
                                        height: Constants.stopWatchBackgroundCircleWidthHeight))
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .green

        return view
    }()
    
    private var startAndStopButton: UIButton = {
        let button = StopWatchButton(title: "Старт",
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
         lapAndResetButton,
         startAndStopButton,
         lapsTableView,
         lapBackgroundCircleView,
         startStopBackgroundCircleView].forEach {
            
            
            addSubview($0)
        }
        sendSubviewToBack(lapBackgroundCircleView)
        sendSubviewToBack(startStopBackgroundCircleView)
        setupConstraints()
    }
    
    private func setupTimer() {
        
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.21)
            $0.centerX.equalToSuperview()
        }
        
        lapAndResetButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(Constants.stopWatchButtonWidthHeight)
        }
        
        lapBackgroundCircleView.snp.makeConstraints {
            $0.center.equalTo(lapAndResetButton)
            $0.width.height.equalTo(Constants.stopWatchBackgroundCircleWidthHeight)
        }
        
        startStopBackgroundCircleView.snp.makeConstraints {
            $0.center.equalTo(startAndStopButton)
            $0.width.height.equalTo(Constants.stopWatchBackgroundCircleWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(lapAndResetButton)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(Constants.stopWatchButtonWidthHeight)
        }
        
        lapsTableView.snp.makeConstraints {
            $0.top.equalTo(lapAndResetButton.snp.bottom).offset(10)
            $0.leading.equalTo(lapAndResetButton)
            $0.trailing.equalTo(startAndStopButton)
            $0.bottomMargin.equalToSuperview()
        }
    }
    
    @objc func didTapStartAndStopButton() {
        if isTimerRunnig {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    @objc func updateTimerLabel() {
        setTimeLabel(value: Int)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001,
                                     target: self,
                                     selector: #selector(updateTimerLabel),
                                     userInfo: nil,
                                     repeats: true)
        startAndStopButton.setTitle("Стоп", for: .normal)
        isTimerRunnig.toggle()
    }
    
    func stopTimer() {
        timeLabel.text = timer?.timeInterval.formatted()
        startAndStopButton.setTitle("Старт", for: .normal)
        isTimerRunnig.toggle()
    }
    
    func resetTimer() {
        timeLabel.text = Constants.timerStartTime
        timer?.invalidate()
        timer = nil
    }
    
    func addLapTimeToTable() {
        //timeLabel.text = timer?.timeInterval.formatted()
    }
    
    func setTimeLabel(_ value: Int) {
        let time = secondsToHoursMinutesSeconds(value)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timeLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        //let milSec = ()
        return (hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
}

extension StopWatchView: UITableViewDelegate, UITableViewDataSource {
    
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
