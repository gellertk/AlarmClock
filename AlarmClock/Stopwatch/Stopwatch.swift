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
    
    public var elapsedLastLapTime: Double {
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
        case accumulatedTime
        case elapsedTime
    }
    
    init(stopwatchViewControllerDelegate: StopwatchViewControllerDelegate) {
        self.stopwatchViewControllerDelegate = stopwatchViewControllerDelegate
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isRunning = try values.decode(Bool.self, forKey: .isRunning)
        lapTimes = try values.decode([TimeInterval].self, forKey: .lapTimes)
        startTime = try values.decode(Date.self, forKey: .startTime)
        accumulatedTime = try values.decode(TimeInterval.self, forKey: .accumulatedTime)
        elapsedTime = try values.decode(TimeInterval.self, forKey: .elapsedTime)
    }

    public func start() {
        if lapTimes.isEmpty {
            addLap()
        }
        initializeTimer()
        startTime = Date()
        isRunning = true
    }
    
    public func stop() {
        deinitializeTimer()
        lapTimes[lapTimes.count - 1] = elapsedLastLapTime
        accumulatedTime = getElapsedTime()
        saveData()
    }
    
    public func reset() {
        deinitializeTimer()
        startTime = nil
        accumulatedTime = 0
        elapsedTime = 0
        lapTimes.removeAll()
        saveData()
    }
    
    public func addLap() {
        if !lapTimes.isEmpty {
            lapTimes[lapTimes.count - 1] = elapsedLastLapTime
        }
        lapTimes.append(0.0)
    }
    
    private func initializeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(didTimeChange),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer ?? Timer(), forMode: .common)
    }
    
    private func deinitializeTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    private func getElapsedTime() -> TimeInterval {
        return -(startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime
    }
    
    public func saveData() {
        do {
            try UserDefaults.standard.saveObject(self, forKey: Constants.userDefaultsStopwatchKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func loadSavedData() {
        do {
            let profile = try UserDefaults.standard.getObject(forKey: Constants.userDefaultsStopwatchKey, castTo: Stopwatch.self)
            self.startTime = profile.startTime
            self.isRunning = profile.isRunning
            self.lapTimes  = profile.lapTimes
            self.accumulatedTime = profile.accumulatedTime
            self.elapsedTime = profile.elapsedTime
            
            lapTimes[lapTimes.count - 1] = elapsedLastLapTime
            if isRunning {
                initializeTimer()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getCurrentInterfaceType() -> InterfaceType {
        var interface: InterfaceType = .stopwatchInitial
        if isRunning {
            interface = .stopwatchRunning
        } else if !lapTimes.isEmpty {
            interface = .stopwatchPaused
        }
        
        return interface
    }
    
    @objc func didTimeChange() {
        elapsedTime = getElapsedTime()
        stopwatchViewControllerDelegate?.didTimeChange()
        saveData()
    }
    
}
