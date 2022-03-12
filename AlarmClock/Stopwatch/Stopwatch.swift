//
//  Stopwatch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

class Stopwatch {
    
    public weak var stopwatchViewDelegate: StopwatchViewDelegate?
    
    public var roundedElapsedTime: TimeInterval {
        elapsedTime.rounded(to: 2)
    }
    private var elapsedTime: TimeInterval = 0
    public var isRunning = false
    
    private var timer: Timer?
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
   
    init(stopwatchViewDelegate: StopwatchViewDelegate) {
        self.stopwatchViewDelegate = stopwatchViewDelegate
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
        stopwatchViewDelegate?.updateTimer()
    }
    
    private func getElapsedTime() -> TimeInterval {
        return (-(startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime).rounded(to: 2)
    }
    
}
