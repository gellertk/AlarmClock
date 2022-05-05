//
//  AlarmRepeatingTypeViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 05.05.2022.
//

import UIKit

class AlarmRepeatingTypeViewController: UIViewController {

    private let alarmRepeatingTypeView = AlarmRepeatingTypeView()
    
    init(repeatingTypes: AlarmRepeatingType) {
        //repeatingTypes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = alarmRepeatingTypeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Повтор"
        setupDelegates()
    }
    
    func setupDelegates() {
        alarmRepeatingTypeView.repeatingTypeTableView.delegate = self
        alarmRepeatingTypeView.repeatingTypeTableView.dataSource = self
    }
    
}

extension AlarmRepeatingTypeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return K.Numeric.alarmSettingTableHeightForRow
    }
    
}

extension AlarmRepeatingTypeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmRepeatingTypeTableViewCell.reuseId) as? AlarmRepeatingTypeTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.setupContent()
        
        return cell
    }
    
}
