//
//  Stopwatch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

final class Stopwatch: Codable {
    
    public weak var stopwatchViewControllerDelegate: StopwatchViewControllerDelegate?
    
    public var elapsedTime: TimeInterval = 0
    public var lapTimes: [TimeInterval] = []
    
    public var elapsedLapTime: Double {
        if lapTimes.count > 1 {
            return (elapsedTime - lapTimes.reduce(0, +) + lapTimes[lapTimes.count - 1])
        }
        return elapsedTime
    }
    
    private var isRunning = false
    private var timer: Timer?
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    
    private enum CodingKeys: String, CodingKey {
        case isRunning
        case lapTimes
        case startTime
    }
    
    init(stopwatchViewControllerDelegate: StopwatchViewControllerDelegate) {
        self.stopwatchViewControllerDelegate = stopwatchViewControllerDelegate
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isRunning = try values.decode(Bool.self, forKey: .isRunning)
        lapTimes = try values.decode([TimeInterval].self, forKey: .lapTimes)
        startTime = try values.decode(Date.self, forKey: .startTime)
    }
    
    public func start() {
        if lapTimes.isEmpty {
            addLap()
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(didTimeChange),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer ?? Timer(), forMode: .common)
        //let profile = try UserDefaults.standard.getObject(forKey: "stopwatch", castTo: Stopwatch.self)
//        if let _ = startTime {
//        } else {
//
//        }
        startTime = Date()

        //startTime = startTime == nil ?
        isRunning = true
    }
    
    public func stop() {
        stopTimer()
        accumulatedTime = getElapsedTime()
        lapTimes[lapTimes.count - 1] = elapsedLapTime
        saveData()
    }
    
    public func reset() {
        stopTimer()
        startTime = nil
        accumulatedTime = 0
        elapsedTime = 0
        lapTimes.removeAll()
        saveData()
    }
    
    public func addLap() {
        if !lapTimes.isEmpty {
            lapTimes[lapTimes.count - 1] = elapsedLapTime
        }
        lapTimes.append(0.0)
        saveData()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    private func getElapsedTime() -> TimeInterval {
        return -(startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime
    }
    
    private func saveData() {
        do {
            try UserDefaults.standard.saveObject(self, forKey: "stopwatch")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func setupData() {
        do {
            let profile = try UserDefaults.standard.getObject(forKey: "stopwatch", castTo: Stopwatch.self)
            self.startTime = profile.startTime
            self.isRunning = profile.isRunning
            self.lapTimes = profile.lapTimes
            self.elapsedTime = lapTimes.reduce(0, +)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func didTimeChange() {
        elapsedTime = getElapsedTime()
        stopwatchViewControllerDelegate?.didTimeChange()
    }
    
}
