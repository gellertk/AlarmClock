//
//  ViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

class WorldClockViewController: UIViewController {
    
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
        setupView()
        setupNavigationController()
        fillWorldClocks()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Constant.Color.secondaryInterface
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.topItem?.setLeftBarButton(UIBarButtonItem(title: "Править",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(didTapEditButton)), animated: false)
        navigationController?.navigationBar.topItem?.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "plus"),
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
        for city in Constant.Collection.worldClockCities {
            let worldClock = CoreDataManager.sharedWorldClock.createWorldClock(city)
            worldClocks.insert(worldClock, at: 0)
            worldClockView.worldClockTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    @objc private func didTapEditButton() {
        
    }
    
    @objc public func didTapAddButton(_ sender: UIBarButtonItem) {
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

extension WorldClockViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return worldClocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.String.worldClockCellId, for: indexPath) as? WorldClockTableViewCell else {
            
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
