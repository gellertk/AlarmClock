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
    
    private lazy var stopwatchView: StopwatchView = {
        let view = StopwatchView()
        view.stopwatchViewControllerDelegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatch.setup()
        setupView()
    }
    
    private func addLap() {
        stopwatch.addLap()
        stopwatchView.lapsTableView.reloadData()
    }
    
    private func getCurrentLapTextColor(indexPathRow: Int) -> UIColor {
        
        let lapTime = stopwatch.lapTimes.reversed()[indexPathRow]
        if stopwatch.lapTimes.count >= Constants.stopwatchLapsToCustomizeCount,
           indexPathRow != 0 {
            switch lapTime {
            case stopwatch.lapTimes.dropLast().min():
                
                return Constants.stopwatchFasterLapTextColor
            case stopwatch.lapTimes.dropLast().max():
                
                return Constants.stopwatchSlowestLapTextColor
            default:
                break
            }
        }
        
        return .white
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

extension StopwatchViewController: StopwatchViewControllerDelegate {
    
    func startStopwatch() {
        stopwatch.start()
        stopwatchView.lapsTableView.reloadData()
    }
    
    func stopStopwatch() {
        stopwatch.stop()
    }
    
    func saveLap() {
        addLap()
    }
    
    func resetStopwatch() {
        stopwatch.reset()
        stopwatchView.lapsTableView.reloadData()
    }
    
    func didTimeChange() {
        stopwatchView.updateStopwatchLabels(mainTime: stopwatch.elapsedTime, lapTime: stopwatch.elapsedLapTime)
    }
    
}

extension StopwatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stopwatch.lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.lapCellId) as? LapsTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.setup(lap: String(stopwatch.lapTimes.count - indexPath.row),
                   time: stopwatch.lapTimes.reversed()[indexPath.row],
                   textColor: getCurrentLapTextColor(indexPathRow: indexPath.row))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.stopwatchTableHeightForRow
    }
    
}
