//
//  AlarmWeekDaysView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 05.05.2022.
//

import UIKit

class AlarmWeekDaysView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AlarmWeekDaysTableViewCell.self,
                           forCellReuseIdentifier: AlarmWeekDaysTableViewCell.reuseId)
        tableView.backgroundColor = .black
        tableView.separatorColor = K.Color.tableSeparator
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        
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

private extension AlarmWeekDaysView {
    
    func setupView() {
        overrideUserInterfaceStyle = .dark
        backgroundColor = K.Color.disabledBackground
        [
            tableView
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(90)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(7 * Int(K.Numeric.alarmSettingTableHeightForRow))
        }
    }
    
}