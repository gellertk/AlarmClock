//
//  StopWatchViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

protocol StopwatchViewControllerDelegate: AnyObject {
    func startStopwatch()
    func stopStopwatch()
    func saveLap()
    func resetStopwatch()
    func didTimeChange()
}

class StopwatchViewController: UIViewController {
    
    private lazy var stopwatch = Stopwatch(stopwatchViewControllerDelegate: self)
    
    private var lapTimes: [TimeInterval] = []
    private var elapsedLapTime: Double {
        if lapTimes.count > 1 {
            return (stopwatch.elapsedTime - lapTimes.reduce(0, +) + lapTimes[lapTimes.count - 1])
        }
        return stopwatch.elapsedTime
    }
    
    private lazy var stopwatchView: StopwatchView = {
        let view = StopwatchView()
        view.stopwatchViewControllerDelegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func addLap() {
        if !lapTimes.isEmpty {
            lapTimes[lapTimes.count - 1] = elapsedLapTime
        }
        lapTimes.append(0.0)
        stopwatchView.lapsTableView.reloadData()
    }
    
}

private extension StopwatchViewController {
    
    func setupView() {
        view.addSubview(stopwatchView)
        setupDelegatesAndDataSources()
        setupConstraints()
    }
    
    func setupConstraints() {
        stopwatchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupDelegatesAndDataSources() {
        stopwatchView.lapsTableView.delegate = self
        stopwatchView.lapsTableView.dataSource = self
    }
    
}

extension StopwatchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == stopwatchView.lapsTableView {
            if scrollView.contentOffset.y >= 0 {
                scrollView.contentOffset = CGPoint.zero
            }
        }
    }
}

extension StopwatchViewController: StopwatchViewControllerDelegate {
    
    func startStopwatch() {
        stopwatch.start()
        if lapTimes.isEmpty {
            addLap()
        }
    }
    
    func stopStopwatch() {
        stopwatch.stop()
        lapTimes[lapTimes.count - 1] = elapsedLapTime
    }
    
    func saveLap() {
        addLap()
    }
    
    func resetStopwatch() {
        stopwatch.reset()
        lapTimes.removeAll()
        stopwatchView.lapsTableView.reloadData()
    }
    
    func didTimeChange() {
        stopwatchView.updateStopwatchLabels(mainTime: stopwatch.elapsedTime, lapTime: elapsedLapTime)
    }
    
}

extension StopwatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.lapCellId) as? LapsTableViewCell else {
            
            return UITableViewCell()
        }
        cell.setup(lap: String(lapTimes.count - indexPath.row),
                   time: lapTimes.reversed()[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.stopwatchTableHeightForRow
    }
    
}
