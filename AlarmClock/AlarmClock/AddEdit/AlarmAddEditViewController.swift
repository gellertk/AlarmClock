//
//  AlarmAddEditViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

class AlarmAddEditViewController: UIViewController {
    
    var alarm: Alarm?
    
    private let alarmAddEditView = AlarmAddEditView()
    
    override func loadView() {
        view = alarmAddEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Добавление"
        setupNavigationBarItems()
        setupDelegates()
    }
    
}

private extension AlarmAddEditViewController {
    
    func setupNavigationBarItems() {
        navigationController?.navigationBar.tintColor = .systemOrange
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
        alarmAddEditView.settingTableView.delegate = self
        alarmAddEditView.settingTableView.dataSource = self
    }
    
}

extension AlarmAddEditViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.Numeric.alarmSettingTableHeightForRow
    }
    
}

extension AlarmAddEditViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmSettingsTableViewCell.reuseId) as? AlarmSettingsTableViewCell else {
            
            return UITableViewCell()
        }
        
        if let alarm = alarm {
            cell.setupContent(alarm, with: indexPath.row)
        } else {
            let newAlarm = Alarm(title: "Будильник",
                                 time: Date(),
                                 isEnabled: true,
                                 repeatingTypes: [],
                                 isRepeated: true,
                                 category: .other,
                                 ringtoneId: nil)
            cell.setupContent(newAlarm, with: indexPath.row)
        }
        
        return cell
    }
    
}

private extension AlarmAddEditViewController {
    
    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapSaveButton() {
        dismiss(animated: true)
    }
    
}
