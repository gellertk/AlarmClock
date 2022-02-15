//
//  ViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import TimeZonePicker

class WorldClockViewController: UIViewController {
    
    private var worldClocks: [WorldClock] = []
    
    private lazy var worldClockView: WorldClockView = {
        let view = WorldClockView()
        view.worldClockTableView.delegate = self
        view.worldClockTableView.dataSource = self
        return view
    }()
    
//    private lazy var timeZonePicker: TimeZonePickerViewController = {
//        return TimeZonePickerViewController.getVC(withDelegate: self)
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мировые часы"
        setupView()
        fillWorldClocks()
    }
    
    private func fillWorldClocks() {
        if UserDefaults.isFirstLaunch() {
            createDefaultWorldClocks()
        } else {
            worldClocks = CoreDataManager.sharedWorldClock.fetchWorldClocks()
        }
    }
    
    private func createDefaultWorldClocks() {
        for city in Constants.firstLaunchWorldClocksCities {
            let worldClock = CoreDataManager.sharedWorldClock.createWorldClock(city)
            worldClocks.insert(worldClock, at: 0)
            worldClockView.worldClockTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    @objc private func didTapEditButton() {
        
    }
    
    private func setupView() {
        [worldClockView].forEach { newView in
            newView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(newView)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            worldClockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            worldClockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            worldClockView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            worldClockView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension WorldClockViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldClocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? WorldClockTableViewCell else {
            return UITableViewCell()
        }
        cell.setupData(worldClocks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
}

extension WorldClockViewController: TimeZonePickerDelegate {
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
//        timeZoneName.text = timeZone.identifier
//        timeZoneOffset.text = timeZone.abbreviation()
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapAddButton() {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true)
    }
    
}
