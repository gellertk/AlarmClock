//
//  AlarmSettingsView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

class SettingsView: UIView {
    
    private let timeDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.backgroundColor = K.Color.disabledBackground
        
        return datePicker
    }()
    
    lazy var tableView: TableView = {
        let cellTypes = [ValueTableViewCell.self,
                         SwitchTableViewCell.self]
        let tableView = TableView(cellTypes: cellTypes, isScrollEnabled: false)
        tableView.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SettingsView {
    
    func setupView() {
        overrideUserInterfaceStyle = .dark
        backgroundColor = K.Color.disabledBackground
        [timeDatePicker,
         tableView
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        timeDatePicker.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(50)
            $0.height.equalTo(220)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(timeDatePicker.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
