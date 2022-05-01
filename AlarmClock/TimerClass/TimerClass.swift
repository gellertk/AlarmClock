//
//  Stopwatch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.03.2022.
//

import Foundation

final class TimerClass: Codable {
    
    private var type: TimerType?
    
    public var elapsedLastLapTime: Double {
        if lapTimes.count > 1 {
            return (elapsedTime - lapTimes.reduce(0, +) + lapTimes[lapTimes.count - 1])
        }
        return elapsedTime
    }
    
    public weak var stopwatchViewControllerDelegate: StopwatchViewControllerDelegate?
    public weak var timerViewControllerDelegate: TimerViewControllerDelegate?
    
    private(set) var elapsedTime: TimeInterval = 0
    private(set) var lapTimes: [TimeInterval] = []
    private(set) var isRunning = false
    
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
    
    func start() {
        startTimer()
        startTime = Date()
        isRunning = true
        if lapTimes.isEmpty, type == .stopwatch {
            addLap()
        }
    }
    
    func stop() {
        deinitializeTimer()
        calculateLastLapTime()
        accumulatedTime = getElapsedTime()
        saveData()
    }
    
    func reset() {
        deinitializeTimer()
        startTime = nil
        accumulatedTime = 0
        elapsedTime = 0
        lapTimes.removeAll()
        saveData()
    }
    
    func addLap() {
        if !lapTimes.isEmpty {
            calculateLastLapTime()
        }
        lapTimes.append(0.0)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: K.Numeric.timeInterval,
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
    
    func saveData() {
        do {
            try UserDefaults.standard.saveObject(self, forKey: type?.rawValue ?? "")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadSavedData() {
        do {
            let profile = try UserDefaults.standard.getObject(forKey: type?.rawValue ?? "", castTo: TimerClass.self)
            startTime = profile.startTime
            isRunning = profile.isRunning
            accumulatedTime = profile.accumulatedTime
            elapsedTime = profile.elapsedTime
            if type == .stopwatch {
                lapTimes = profile.lapTimes
                calculateLastLapTime()
            }
            if isRunning {
                elapsedTime = getElapsedTime()
                startTimer()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func calculateLastLapTime() {
        if type == .stopwatch, !lapTimes.isEmpty {
            lapTimes[lapTimes.count - 1] = elapsedLastLapTime
        }
    }
    
    func getCurrentInterfaceType() -> InterfaceType {
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
        if type == .stopwatch {
            stopwatchViewControllerDelegate?.didTimeChange()
        } else {
            timerViewControllerDelegate?.didTimeChange()
        }
        saveData()
    }
    
}
