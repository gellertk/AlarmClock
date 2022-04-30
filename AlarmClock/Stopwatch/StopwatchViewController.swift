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
    func isPaused() -> Bool
}

class StopwatchViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private lazy var stopwatch: TimerClass = {
        let stopwatch = TimerClass(type: .stopwatch)
        stopwatch.stopwatchViewControllerDelegate = self
        
        return stopwatch
    }()
    
    private lazy var stopwatchView: StopwatchView = {
        let view = StopwatchView(interfaceType: stopwatch.getCurrentInterfaceType())
        view.stopwatchViewControllerDelegate = self
        view.updateStopwatchLabels(mainTime: stopwatch.elapsedTime, lapTime: stopwatch.elapsedLastLapTime)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatch.loadSavedData()
        setupView()
        setupDelegatesAndDataSources()
    }
    
}

private extension StopwatchViewController {
    
    func setupView() {
        view.addSubview(stopwatchView)
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
        stopwatchView.scrollView.delegate = self
    }
    
    private func getCurrentLapTextColor(indexPathRow: Int) -> UIColor {
        
        let lapTime = stopwatch.lapTimes.reversed()[indexPathRow]
        if stopwatch.lapTimes.count >= K.Numeric.lapsToCustomizeCount,
           indexPathRow != 0 {
            switch lapTime {
            case stopwatch.lapTimes.dropLast().min():
                
                return K.Color.fasterLapText
            case stopwatch.lapTimes.dropLast().max():
                
                return K.Color.slowestLapText
            default:
                break
            }
        }
        
        return .white
    }
    
}

extension StopwatchViewController: StopwatchViewControllerDelegate {
    
    func isPaused() -> Bool {
        return stopwatch.elapsedTime != 0
    }
    
    func startStopwatch() {
        stopwatch.start()
        stopwatchView.lapsTableView.reloadData()
    }
    
    func stopStopwatch() {
        stopwatch.stop()
    }
    
    func saveLap() {
        stopwatch.addLap()
        stopwatchView.lapsTableView.reloadData()
    }
    
    func resetStopwatch() {
        stopwatch.reset()
        stopwatchView.lapsTableView.reloadData()
    }
    
    func didTimeChange() {
        stopwatchView.updateStopwatchLabels(mainTime: stopwatch.elapsedTime, lapTime: stopwatch.elapsedLastLapTime)
    }
    
}

extension StopwatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stopwatch.lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LapsTableViewCell.reuseId) as? LapsTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.setup(lap: String(stopwatch.lapTimes.count - indexPath.row),
                   time: stopwatch.lapTimes.reversed()[indexPath.row],
                   textColor: getCurrentLapTextColor(indexPathRow: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return K.Numeric.stopwatchTableHeightForRow
    }
    
}

extension StopwatchViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stopwatchView.pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
    
}
