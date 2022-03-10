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
    
    private lazy var stopwatch = Stopwatch(delegate: self)
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.timerStartTime
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        
        return label
    }()
    
    private var lapAndResetButton: StopwatchButton = {
        let button = StopwatchButton()
        button.addTarget(self, action: #selector(didTapLapAndResetButton), for: .touchUpInside)
        
        return button
    }()
    
    //TODO: Code doubled make Stopwatch button as view with background view and button
    private lazy var lapAndResetBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Constants.stopwatchBackgroundCircleWidthHeight,
                                        height: Constants.stopwatchBackgroundCircleWidthHeight))
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderWidth = 2
        view.backgroundColor = backgroundColor
        
        return view
    }()
    
    //TODO: Code doubled make Stopwatch button as view with background view and button
    private lazy var startAndStopBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Constants.stopwatchBackgroundCircleWidthHeight,
                                        height: Constants.stopwatchBackgroundCircleWidthHeight))
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderWidth = 2
        view.backgroundColor = backgroundColor
        
        return view
    }()
    
    private var startAndStopButton: StopwatchButton = {
        let button = StopwatchButton()
        button.addTarget(self, action: #selector(didTapStartAndStopButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(didPushButton(sender:)), for: .touchDown)
        
        return button
    }()
    
    @objc func didPushButton(sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.05)
        startAndStopBackgroundView.layer.borderColor = sender.backgroundColor?.withAlphaComponent(0.05).cgColor
    }
    
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
        
        setupButtons()
        
        [timeLabel,
         lapAndResetButton,
         startAndStopButton,
         lapsTableView,
         lapAndResetBackgroundView,
         startAndStopBackgroundView].forEach {
            
            addSubview($0)
        }
        
        sendSubviewToBack(lapAndResetBackgroundView)
        sendSubviewToBack(startAndStopBackgroundView)
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
            $0.width.height.equalTo(Constants.stopwatchButtonWidthHeight)
        }
        
        lapAndResetBackgroundView.snp.makeConstraints {
            $0.center.equalTo(lapAndResetButton)
            $0.width.height.equalTo(Constants.stopwatchBackgroundCircleWidthHeight)
        }
        
        startAndStopBackgroundView.snp.makeConstraints {
            $0.center.equalTo(startAndStopButton)
            $0.width.height.equalTo(Constants.stopwatchBackgroundCircleWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(lapAndResetButton)
            $0.trailing.equalToSuperview().offset(-Constants.stopwatchBorderConstraint)
            $0.width.height.equalTo(Constants.stopwatchButtonWidthHeight)
        }
        
        lapsTableView.snp.makeConstraints {
            $0.top.equalTo(lapAndResetButton.snp.bottom).offset(10)
            $0.leading.equalTo(lapAndResetButton)
            $0.trailing.equalTo(startAndStopButton)
            $0.bottomMargin.equalToSuperview()
        }
    }
    
    @objc func didTapStartAndStopButton() {
        if stopwatch.isRunning {
            stopTimer()
        } else {
            startTimer()
        }
        setupButtons()
    }
    
    @objc func didTapLapAndResetButton() {
        if stopwatch.isRunning {
            addLap()
        } else {
            resetTimer()
        }
        setupButtons()
    }
    
    private func startTimer() {
        stopwatch.start()
        //        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
        //            cell.stopwatch.start()
        //        }
        if lapTimes.isEmpty {
            addLap()
        }
    }
    
    private func stopTimer() {
        stopwatch.stop()
        //        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
        //            cell.stopwatch.stop()
        //        }
    }
    
    private func resetTimer() {
        timeLabel.text = Constants.timerStartTime
        stopwatch.reset()
        lapTimes.removeAll()
        lapsTableView.reloadData()
    }
    
    private func addLap() {
//        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
//            lapTimes.append(cell.stopwatch.elapsedTime)
//        } else {
//            lapTimes.append(0.0)
//        }
        lapTimes.append(stopwatch.elapsedTime)
        lapsTableView.reloadData()
    }
    
    private func setupButtons() {
        if lapTimes.isEmpty {
            setupDisabledLapButton()
            setupStartButton()
            
        } else if stopwatch.isRunning {
            setupLapEnabledButton()
            setupStopButton()
            
        } else {
            setupResetButton()
            setupStartButton()
        }
    }
    
    private func setupStartButton() {
        startAndStopButton.setupAsStartButton()
        startAndStopBackgroundView.layer.borderColor = Constants.stopwatchStartButtonBackgroundColor.cgColor
    }
    
    private func setupStopButton() {
        startAndStopButton.setupAsStopButton()
        startAndStopBackgroundView.layer.borderColor = Constants.stopwatchStopButtonBackgroundColor.cgColor
    }
    
    private func setupResetButton() {
        lapAndResetButton.setupAsResetButton()
    }
    
    private func setupLapEnabledButton() {
        lapAndResetButton.setupAsLapEnabledButton()
        lapAndResetBackgroundView.layer.borderColor = Constants.stopwatchLapButtonEnabledBackgroundColor.cgColor
    }
    
    private func setupDisabledLapButton() {
        lapAndResetButton.setupAsLapDisabledButton()
        lapAndResetBackgroundView.layer.borderColor = Constants.stopwatchLapButtonDisabledBackgroundColor.cgColor
    }
    
}

extension StopwatchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.lapCellId) as? LapsTableViewCell else {
            
            return UITableViewCell()
        }
        let lapNumber = String(lapTimes.count - (indexPath.row))
        cell.setup(lap: lapNumber, time: lapTimes[indexPath.row].convertToString(), currentRow: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.stopwatchHeightForRow
    }
    
}

extension StopwatchView: StopwatchViewDelegate, LapsTableViewCellDelegate {
    
    func updateTimer() {
        timeLabel.text = stopwatch.elapsedTime.convertToString()
        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
            cell.setup(lap: String(lapTimes.count), time: stopwatch.elapsedTime.convertToString(), currentRow: 0)
        }
        lapTimes[lapTimes.count - 1] = stopwatch.elapsedTime
    }
    
}
