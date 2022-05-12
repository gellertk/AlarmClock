//
//  AlarmSettingsViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

protocol AlarmUpdateDelegate: AnyObject {
    func update(alarm: Alarm)
}

class SettingsViewController: UIViewController {
    
    var settingCells: [CellType] = []
    
    var alarm: Alarm?
    
    private let alarmSettingsView = SettingsView()
    
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
        fillCells()
    }
    
}

private extension SettingsViewController {
    
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
    
    func fillCells() {
        guard let alarm = alarm else {
            return
        }
        
        settingCells = [
            .valueCell(options: ValueCellOption(text: "Повтор",
                                              secondaryText: alarm.formatedWeekDays()) { [weak self] in self?.toWeekDaysVC() }),
            
                .valueCell(options: ValueCellOption(text: "Название",
                                                  secondaryText: alarm.formatedWeekDays()) { [weak self] in self?.toTitleVC() }),
            
                .valueCell(options: ValueCellOption(text: "Мелодия",
                                                  secondaryText: alarm.formatedWeekDays()) { [weak self] in self?.toMelodyVC() }),
            
                .switchCell(options: SwitchCellOption(text: "Повторение сигнала",
                                                      isOn: alarm.isRepeated) { [weak self] in self?.alarm?.isRepeated.toggle() } )
        ]
        
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch settingCells[indexPath.row] {
        case .valueCell(let model):
            model.handler()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let alarm = alarm else {
            return UITableViewCell()
        }
        
        switch settingCells[indexPath.row] {
        case .valueCell(var options):
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            ValueTableViewCell.reuseIdentifier, for:
                                                            indexPath) as? ValueTableViewCell else {
                return UITableViewCell()
            }
            options.secondaryText = alarm[indexPath.row]
            cell.configure(with: options)
            
            return cell
        case .switchCell(var options):
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            SwitchTableViewCell.reuseIdentifier, for:
                                                            indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            
            options.isOn = alarm.isRepeated
            cell.configure(with: options)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension SettingsViewController: AlarmUpdateDelegate {
    
    func update(alarm: Alarm) {
        self.alarm = alarm
        alarmSettingsView.tableView.reloadData()
    }
    
}

private extension SettingsViewController {
    
    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapSaveButton() {
        dismiss(animated: true)
    }
    
    func toWeekDaysVC() {
        guard let alarm = alarm else {
            return
        }
        
        let weekDaysVC = WeekDaysViewController(alarm: alarm)
        weekDaysVC.delegate = self
        navigationController?.pushViewController(weekDaysVC,
                                                 animated: true)
    }
    
    func toTitleVC() {
        guard let alarm = alarm else {
            return
        }
        
        let titleVC = AlarmTitleViewController(alarm: alarm)
        titleVC.delegate = self
        navigationController?.pushViewController(titleVC,
                                                 animated: true)
    }
    
    func toMelodyVC() {
        guard let alarm = alarm else {
            return
        }
        
        let melodyVC = MelodyViewController(alarm: alarm)
        melodyVC.delegate = self
        navigationController?.pushViewController(melodyVC,
                                                 animated: true)
    }
    
}
