//
//  Stopwatch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

class Stopwatch {
    
    public weak var stopwatchViewDelegate: StopwatchViewDelegate?
    
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private weak var timer: Timer?
    
    public var isRunning = false
    
    private(set) var elapsedTime: TimeInterval = 0
    
    init(delegate: StopwatchViewDelegate) {
        stopwatchViewDelegate = delegate
    }
    
    public func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.001,
                                     target: self,
                                     selector: #selector(didTimeChange),
                                     userInfo: nil,
                                     repeats: true)
        startTime = Date()
        isRunning = true
    }
    
    public func stop() {
        //timer?.cancel()
        timer = nil
        accumulatedTime = getElapsedTime()
        startTime = nil
        isRunning = false
    }
    
    public func reset() {
        timer?.invalidate()
        timer = nil
        accumulatedTime = 0
        elapsedTime = 0
        startTime = nil
        isRunning = false
    }
    
    @objc func didTimeChange() {
        elapsedTime = getElapsedTime()
        stopwatchViewDelegate?.updateTimer()
    }
    
    private func getElapsedTime() -> TimeInterval {
        return -(startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime
    }
    
}
