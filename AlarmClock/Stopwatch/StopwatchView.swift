//
//  StopWatchView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

protocol StopwatchViewDelegate: AnyObject {
    func didTapStartStopwatchButton()
    func didTapStopStopwatchButton()
    func didTapLapStopwatchButton()
    func didTapResetStopwatchButton()
    func didTapDisabledLapStopwatchButton()
}

class StopwatchView: UIView {
    
    public weak var stopwatchViewControllerDelegate: StopwatchViewControllerDelegate?
    
    private var lapTimes: [TimeInterval] = []
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.stopwatchStartTime
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 88, weight: .thin)
        
        return label
    }()
    
    private lazy var lapAndResetButton: CircleButtonView = {
        let button = CircleButtonView(type: .lapDisabled, delegate: self)
        
        return button
    }()
    
    private lazy var startAndStopButton: CircleButtonView = {
        let button = CircleButtonView(type: .start, delegate: self)
        
        return button
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
            $0.leading.equalToSuperview().offset(Constants.standartBorderConstraint)
            $0.trailing.equalToSuperview().offset(-Constants.standartBorderConstraint + 1)
        }
        
        lapAndResetButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.standartBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight)
        }
        
        startAndStopButton.snp.makeConstraints {
            $0.centerY.equalTo(lapAndResetButton)
            $0.trailing.equalToSuperview().offset(-Constants.standartBorderConstraint)
            $0.width.height.equalTo(Constants.circleButtonViewWidthHeight + 1)
        }
        
        lapsTableView.snp.makeConstraints {
            $0.top.equalTo(lapAndResetButton.snp.bottom).offset(10)
            $0.leading.equalTo(lapAndResetButton)
            $0.trailing.equalTo(startAndStopButton)
            $0.bottomMargin.equalToSuperview()
        }
    }
    
    private func setupRunningInterface() {
        lapAndResetButton.setupBy(type: .lapEnabled)
        startAndStopButton.setupBy(type: .stop)
    }
    
    private func setupPauseInterface() {
        lapAndResetButton.setupBy(type: .reset)
        startAndStopButton.setupBy(type: .start)
    }
    
    private func setupInitialInterface() {
        lapAndResetButton.setupBy(type: .lapDisabled)
        timeLabel.text = Constants.stopwatchStartTime
        lapTimes.removeAll()
        lapsTableView.reloadData()
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
        cell.setup(lap: String(lapTimes.count - indexPath.row),
                   time: lapTimes.reversed()[indexPath.row].convertToStopwatchString())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.stopwatchTableHeightForRow
    }
    
}

extension StopwatchView: LapsTableViewCellDelegate {
    
    func updateStopwatch() {
        //        timeLabel.text = stopwatch.elapsedTime.stringFromTimeInterval()
        //        if let cell = lapsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LapsTableViewCell {
        //            cell.setup(lap: String(lapTimes.count), time: cellStopwatchElapsedTime.stringFromTimeInterval())
        //        }
    }
    
}

extension StopwatchView: StopwatchViewDelegate {
    
    func didTapStartStopwatchButton() {
        stopwatchViewControllerDelegate?.startStopwatch()
        setupRunningInterface()
    }
    
    func didTapStopStopwatchButton() {
        stopwatchViewControllerDelegate?.stopStopwatch()
        setupPauseInterface()
    }
    
    func didTapLapStopwatchButton() {
        stopwatchViewControllerDelegate?.saveLap()
        setupRunningInterface()
    }
    
    func didTapDisabledLapStopwatchButton() {
        setupInitialInterface()
    }
    
    func didTapResetStopwatchButton() {
        stopwatchViewControllerDelegate?.resetStopwatch()
        setupInitialInterface()
    }
    
}
