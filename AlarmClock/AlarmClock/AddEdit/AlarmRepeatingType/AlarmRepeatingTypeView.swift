//
//  AlarmRepeatingTypeView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 05.05.2022.
//

import UIKit

class AlarmRepeatingTypeView: UIView {
    
    lazy var repeatingTypeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AlarmRepeatingTypeTableViewCell.self,
                           forCellReuseIdentifier: AlarmRepeatingTypeTableViewCell.reuseId)
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

private extension AlarmRepeatingTypeView {
    
    func setupView() {
        overrideUserInterfaceStyle = .dark
        backgroundColor = K.Color.disabledBackground
        [
            repeatingTypeTableView
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        repeatingTypeTableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
//            $0.height.equalTo(AlarmSettings.allCases.count * Int(K.Numeric.alarmSettingTableHeightForRow))
        }
    }
    
}
