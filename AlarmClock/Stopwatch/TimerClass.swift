//
//  Stopwatch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

final class TimerClass: Codable {
    
    private var type: TimerType?
            
    public weak var stopwatchViewControllerDelegate: StopwatchViewControllerDelegate?
    public weak var timerViewControllerDelegate: TimerViewControllerDelegate?
    
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
    
    init(type: TimerType) {
        self.type = type
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isRunning = try values.decode(Bool.self, forKey: .isRunning)
        startTime = try values.decode(Date.self, forKey: .startTime)
        accumulatedTime = try values.decode(TimeInterval.self, forKey: .accumulatedTime)
        elapsedTime = try values.decode(TimeInterval.self, forKey: .elapsedTime)
        lapTimes = try values.decode([TimeInterval].self, forKey: .lapTimes)
    }
    
    public func start() {
        startTimer()
        startTime = Date()
        isRunning = true
        if lapTimes.isEmpty {
            addLap()
        }
    }
    
    public func stop() {
        deinitializeTimer()
        saveLastLap()
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
        if type == .stopwatch {
            if !lapTimes.isEmpty {
                saveLastLap()
            }
            lapTimes.append(0.0)
        }
    }
    
    private func startTimer() {
        var timeInterval = 1.0
        if type == .stopwatch {
            timeInterval = 0.01
        }
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
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
        
        if type == .stopwatch {
            
            return -(startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime
        }
        
        return (startTime?.timeIntervalSinceNow ?? 0) + accumulatedTime
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
            let profile = try UserDefaults.standard.getObject(forKey: Constants.userDefaultsStopwatchKey, castTo: TimerClass.self)
            self.startTime = profile.startTime
            self.isRunning = profile.isRunning
            self.lapTimes  = profile.lapTimes
            self.accumulatedTime = profile.accumulatedTime
            self.elapsedTime = profile.elapsedTime
            
            saveLastLap()
            if isRunning {
                startTimer()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func saveLastLap() {
        if type == .stopwatch {
            lapTimes[lapTimes.count - 1] = elapsedLastLapTime
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
        timerViewControllerDelegate?.didTimeChange()
        saveData()
    }
    
}
