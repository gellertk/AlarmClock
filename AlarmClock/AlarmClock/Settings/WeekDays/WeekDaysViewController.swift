//
//  AlarmWeekDaysViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 05.05.2022.
//

import UIKit

class WeekDaysViewController: UIViewController {
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?
    
    private let alarmWeekDaysView = WeekDaysView()
    
    private var cells: [CellType] = []
    
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
        fillCells()
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

extension WeekDaysViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CheckmarkTableViewCell {
            alarm?.weekDays[indexPath.row]?.toggle()
            cell.toggleCheckmark()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension WeekDaysViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let alarm = alarm else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckmarkTableViewCell.reuseIdentifier, for: indexPath) as? CheckmarkTableViewCell else {
            
            return UITableViewCell()
        }
        
        switch cells[indexPath.row] {
        case .checkmarkedCell(var options):
            options.isCheckmarked = alarm.weekDays[indexPath.row] ?? false
            cell.configure(with: options)
        default:
            break
        }
        
        return cell
    }
    
}

private extension WeekDaysViewController {
    
    func fillCells() {
        
        guard let alarm = alarm else {
            return
        }
        
        for index in 0...6 {
            cells += [
                .checkmarkedCell(options: CheckmarkCellOption(text: index.toWeekDayFullString(),
                                                              isCheckmarkLeft: false,
                                                              isCheckmarked: alarm.weekDays[index] ?? false, handler: nil))
            ]
        }
        
    }
    
}
