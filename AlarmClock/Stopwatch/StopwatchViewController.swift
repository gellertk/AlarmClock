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
    func updateStopwatch()
}

class StopwatchViewController: UIViewController {
    
    private lazy var stopwatch = Stopwatch(stopwatchViewControllerDelegate: self)
    
    private var lapTimes: [TimeInterval] = []
    private var cellStopwatchElapsedTime: Double {
        if lapTimes.count > 1 {
            return (stopwatch.elapsedTime - lapTimes.reduce(0, +) + lapTimes[lapTimes.count - 1])
        }
        return stopwatch.elapsedTime
    }
    
    private lazy var stopwatchView: UIView = {
        let view = StopwatchView()
        view.stopwatchViewControllerDelegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(stopwatchView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stopwatchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //    private func startStopwatch() {
    //        stopwatch.start()
    //        if lapTimes.isEmpty {
    //            addLap()
    //        }
    //    }
    //
    //    private func stopStopwatch() {
    //        stopwatch.stop()
    //        lapTimes[lapTimes.count - 1] = cellStopwatchElapsedTime
    //    }
    //
    //    private func resetStopwatch() {
    //        //timeLabel.text = Constants.stopwatchStartTime
    //        stopwatch.reset()
    //        lapTimes.removeAll()
    //        //lapsTableView.reloadData()
    //    }
    //
    //    private func addLap() {
    //        if !lapTimes.isEmpty {
    //            lapTimes[lapTimes.count - 1] = cellStopwatchElapsedTime
    //        }
    //        lapTimes.append(0.0)
    //        //lapsTableView.reloadData()
    //    }
    
    
}

extension StopwatchViewController: StopwatchViewControllerDelegate {
    
    func startStopwatch() {
        
    }
    
    func stopStopwatch() {
        
    }
    
    func saveLap() {
        
    }
    
    func resetStopwatch() {
        
    }
    
    func updateStopwatch() {
        
    }
    
}
