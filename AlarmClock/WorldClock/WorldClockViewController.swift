//
//  ViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

class WorldClockViewController: UIViewController {
    
    private var timer: Timer?
    
    private var worldClocks: [WorldClock] = []
    
    private lazy var worldClockView: WorldClockView = {
        let view = WorldClockView()
        view.worldClockTableView.delegate = self
        view.worldClockTableView.dataSource = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мировые часы"
        setupTimer()
        setupView()
        setupNavigationBarItems()
        fillWorldClocks()
    }
    
    private func setupNavigationBarItems() {
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Править",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(didTapEditButton)), animated: false)
        navigationItem.setRightBarButton(UIBarButtonItem(image: K.SystemImage.plus,
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(didTapAddButton)), animated: false)
    }
    
    private func fillWorldClocks() {
        if UserDefaults.isFirstLaunch() {
            createDefaultWorldClocks()
        } else {
            worldClocks = CoreDataManager.sharedWorldClock.fetchWorldClocks()
        }
    }
    
    private func createDefaultWorldClocks() {
        for city in K.Collection.worldClockCities {
            let worldClock = CoreDataManager.sharedWorldClock.createWorldClock(city)
            worldClocks.insert(worldClock, at: 0)
            worldClockView.worldClockTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    @objc func didTapEditButton() {
        UIView.animate(withDuration: 0.3) {
            self.worldClockView.worldClockTableView.isEditing.toggle()
        }
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        present(TimeZoneViewController(), animated: true)
    }
    
    private func setupView() {
        view.addSubview(worldClockView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        worldClockView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

private extension WorldClockViewController {
    
    func setupTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc func updateTimer() {
        guard let visibleRowsIndexPaths = worldClockView.worldClockTableView.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in visibleRowsIndexPaths {
            if let cell = worldClockView.worldClockTableView.cellForRow(at: indexPath) as? WorldClockTableViewCell {
                cell.timeLabel.text = Date().toHoursMinutes()
            }
        }
    }
    
}

extension WorldClockViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return worldClocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldClockTableViewCell.reuseIdentifier, for: indexPath) as? WorldClockTableViewCell else {
            
            return UITableViewCell()
        }
        cell.setupData(worldClocks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 95
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
}
