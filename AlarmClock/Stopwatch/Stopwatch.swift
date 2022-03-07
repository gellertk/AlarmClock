//
//  Stopwatch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

class Stopwatch {
    
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private var timer: Timer?
    
    var isRunning = false {
        didSet {
            if self.isRunning {
                self.start()
            } else {
                self.stop()
            }
        }
    }
    private(set) var elapsedTime: TimeInterval = 0
    
    let id = UUID()
    
    private func start() -> Void {
        timer?.cancel()
    timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            elapsedTime = getElapsedTime()
        }
    startTime = Date()
    }
    
    private func stop() -> Void {
    timer?.cancel()
        timer = nil
    accumulatedTime = getElapsedTime()
        startTime = nil
    }
    
    func reset() -> Void {
        accumulatedTime = 0
        elapsedTime = 0
        startTime = nil
        isRunning = false
    }
    
    private func getElapsedTime() -> TimeInterval {
        return -(startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime
    }
}
