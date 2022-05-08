//
//  AlarmSettingsViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

class AlarmSettingsViewController: UIViewController {
    
    var alarm: Alarm?
    
    private let alarmSettingsView = AlarmSettingsView()
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = alarmSettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Добавление"
        setupNavigationBarItems()
        setupDelegates()
    }
    
}

private extension AlarmSettingsViewController {
    
    func setupNavigationBarItems() {
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Отменить",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(didTapCancelButton)), animated: false)
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Сохранить",
                                                         style: .done,
                                                         target: self,
                                                         action: #selector(didTapSaveButton)), animated: false)
        
    }
    
    func setupDelegates() {
        alarmSettingsView.tableView.delegate = self
        alarmSettingsView.tableView.dataSource = self
        
    }
    
}

extension AlarmSettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let alarm = alarm else {
            return
        }
        switch indexPath.row {
        case 0:
            let weekDaysVC = AlarmWeekDaysViewController(repeatingWeekDays: alarm.repeatingWeekDays)
            weekDaysVC.delegate = self
            navigationController?.pushViewController(weekDaysVC,
                                                     animated: true)
        case 1:
            print(1)
        default:
            print(1)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return K.Numeric.alarmSettingTableHeightForRow
    }
    
}

extension AlarmSettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmSettings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        AlarmSettingsTableViewCell.reuseId) as? AlarmSettingsTableViewCell,
              let alarm = alarm else {
            
            return UITableViewCell()
        }
        
        let config = SettingsContentConfiguration(text: AlarmSettings.allCases[indexPath.row].rawValue)
        cell.contentConfiguration = config
                
        //cell.configure(alarm, for: indexPath.row)
        
        return cell
    }
    
}

extension AlarmSettingsViewController: AlarmDelegate {
    
    func update(weekDays: [Int]) {
        alarm?.repeatingWeekDays = weekDays
        alarmSettingsView.tableView.reloadData()
    }
    
}

private extension AlarmSettingsViewController {
    
    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapSaveButton() {
        dismiss(animated: true)
    }
    
}
