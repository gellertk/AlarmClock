//
//  TimeZoneView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.02.2022.
//

import UIKit
import SnapKit

class TimeZoneView: UIView {
    
    public lazy var timeZoneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(TimeZoneTableViewCell.self, forCellReuseIdentifier: TimeZoneTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(timeZoneTableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        timeZoneTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension TimeZoneView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TimeZone.knownTimeZoneIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimeZoneTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? TimeZoneTableViewCell else {
            
            return UITableViewCell()
        }
        //NSTimeZone(name: TimeZone.knownTimeZoneIdentifiers[2])?.localizedName(.generic, locale: Locale(identifier: "ru_RU"))
        cell.setupData(city: TimeZone.knownTimeZoneIdentifiers[indexPath.row])
        
        return cell
    }
    
}


