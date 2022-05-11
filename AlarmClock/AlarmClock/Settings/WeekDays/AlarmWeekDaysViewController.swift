//
//  AlarmWeekDaysViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 05.05.2022.
//

import UIKit

class AlarmWeekDaysViewController: UIViewController {
        
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?

    private let alarmWeekDaysView = AlarmWeekDaysView()
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = alarmWeekDaysView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Повтор"
        setupDelegates()
    }
    
    func setupDelegates() {
        alarmWeekDaysView.tableView.delegate = self
        alarmWeekDaysView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let alarm = alarm else {
                return
            }
            delegate?.update(alarm: alarm)
        }
    }
    
}

extension AlarmWeekDaysViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return K.Numeric.defaultHeightForRow
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                alarm?.weekDays.append(indexPath.row)
            } else {
                cell.accessoryType = .none
                alarm?.weekDays.removeAll { $0 == indexPath.row }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AlarmWeekDaysViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let alarm = alarm else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.reuseIdentifier, for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = indexPath.row.getWeekDayFullDescription()
        cell.contentConfiguration = config
        
        if alarm.weekDays.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
}
