//
//  ViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class WorldClockViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    typealias CustomCellRegistrationType = UICollectionView.CellRegistration<CustomListCell, WorldClock>
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, WorldClock>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, WorldClock>
    
    private let mainView = WorldClockView()
    
    private var dataSource: DataSourceType?
    private var worldClocks = Alarm.getAlarms()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мировые часы"
        setupDataSource()
        setupNavigationBarItems()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated:animated)
        mainView.collectionView.isEditing = editing
    }
    
}

private extension WorldClockViewController {
    
    func createCellRegistration() -> CustomCellRegistrationType {
        return CustomCellRegistrationType() { cell, indexPath, item in
            
            //cell.configure(with: item)
        }
    }
    
    func setupDataSource() {
        let cellRegistration = createCellRegistration()
        
        dataSource = DataSourceType(collectionView: mainView.collectionView) {
            collectionView, indexPath, item in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: item)
        }
        
        applySnapshot()
        setupDelegates()
    }
    
    func applySnapshot() {
        var snapshot = SnapshotType()
        snapshot.appendSections([.main])
        snapshot.appendItems(alarms)
        
        dataSource?.apply(snapshot)
    }
    
    func delete(at indexPath: IndexPath) {
        guard let dataSource = dataSource else {
            return
        }
        var snapshot = dataSource.snapshot()
        if let identifier = dataSource.itemIdentifier(for: indexPath) {
            snapshot.deleteItems([identifier])
        }
        dataSource.apply(snapshot)
    }
    
    func setupDelegates() {
        mainView.collectionView.delegate = self
        //mainView.delegate = self
    }
    
    func setupNavigationBarItems() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.primaryAction = UIAction(title: "Править") { [unowned self] _ in
            setEditing(!isEditing, animated: true)
            navigationItem.leftBarButtonItem?.title = isEditing ? "Готово" : "Править"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        navigationItem.rightBarButtonItem?.primaryAction = UIAction() { [unowned self] _ in
            let settingsVC = SettingsViewController(alarm: Alarm.createDefaultAlarm())
            settingsVC.delegate = self
            present(UINavigationController(rootViewController: settingsVC,
                                           prefersLargeTitle: false),
                    animated: true)
        }
        
    }
    
}

extension WorldClockViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let settingsVC = SettingsViewController(alarm: alarms[indexPath.row + 1])
        present(UINavigationController(rootViewController: settingsVC,
                                       prefersLargeTitle: false),
                animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension WorldClockViewController: AlarmClockViewDelegate {
    
    func deleteAlarm(at indexPath: IndexPath) {
        delete(at: indexPath)
    }
    
}

extension WorldClockViewController: AlarmUpdateDelegate {
    
    func update(with alarm: Alarm) {
        alarms.append(alarm)
        guard let dataSource = dataSource else {
            return
        }
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([alarm], toSection: .other)
        dataSource.apply(snapshot)
    }
    
}
