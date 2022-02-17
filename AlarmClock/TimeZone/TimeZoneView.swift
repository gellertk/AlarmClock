//
//  TimeZoneView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.02.2022.
//

import UIKit

class TimeZoneView: UIView {
    
     public lazy var timeZoneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Constant.timeZoneTableViewColor
        tableView.register(TimeZoneTableViewCell.self, forCellReuseIdentifier: Constant.timeZoneCellId)
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
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeZoneTableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeZoneTableView.topAnchor.constraint(equalTo: topAnchor),
            timeZoneTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            timeZoneTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeZoneTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}

extension TimeZoneView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeZone.knownTimeZoneIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.timeZoneCellId,
                                                       for: indexPath) as? TimeZoneTableViewCell else {
            return UITableViewCell()
        }
        //NSTimeZone(name: TimeZone.knownTimeZoneIdentifiers[2])?.localizedName(.generic, locale: Locale(identifier: "ru_RU"))
        cell.setupData(city: TimeZone.knownTimeZoneIdentifiers[indexPath.row])
        return cell
    }
    
}


