//
//  Stopwatch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation
import CloudKit

class Stopwatch {

    public weak var stopwatchViewDelegate: StopwatchViewDelegate?
    
    public var elapsedTime: TimeInterval = 0
    public var isRunning = false
    
    private var timer: Timer?
    private var timerId: String
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
   
    init(delegate: StopwatchViewDelegate, id: String) {
        stopwatchViewDelegate = delegate
        self.timerId = id
    }
    
    public func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(didTimeChange),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer ?? Timer(), forMode: .common)
        startTime = Date()
        isRunning = true
    }
    
    public func stop() {
        stopTimer()
        accumulatedTime = getElapsedTime()
    }
    
    public func reset() {
        stopTimer()
        startTime = nil
        accumulatedTime = 0
        elapsedTime = 0
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    @objc func didTimeChange() {
        elapsedTime = getElapsedTime()
        switch timerId {
        case Constants.mainStopwatchId:
            stopwatchViewDelegate?.updateMainTimer()
        case Constants.cellStopwatchId:
            stopwatchViewDelegate?.updateCellTimer()
        default:
            break
        }
    }
    
    private func getElapsedTime() -> TimeInterval {
        return -(startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime
    }
    
}
