//
//  ViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class WorldClockViewController: UIViewController {
    
    enum Section: String {
        case main
    }
    
    typealias CustomCellRegistrationType = UICollectionView.CellRegistration<WorldClockListCell, WorldClock>
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, WorldClock>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, WorldClock>
    
    private let mainView = WorldClockView()
    
    private var dataSource: DataSourceType?
    private var worldClocks = CoreDataManager.shared.fetchWorldClocks()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мировые часы"
        setupDataSource()
        setupDelegates()
        setupNavigationBarItems()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        mainView.collectionView.isEditing = editing
    }
    
}

private extension WorldClockViewController {
    
    func createCellRegistration() -> CustomCellRegistrationType {
        return CustomCellRegistrationType() { cell, indexPath, item in
            
            cell.configure(timeDifference: "Сегодня, +0 Ч", city: item.city!, time: item.time)
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
        
        dataSource?.reorderingHandlers.canReorderItem = { item in return true }
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = SnapshotType()
        snapshot.appendSections([.main])
        snapshot.appendItems(worldClocks)
        
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
        //mainView.collectionView.delegate = self
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
            let settingsVC = TimeZoneViewController()
            //settingsVC.delegate = self
            present(UINavigationController(rootViewController: settingsVC,
                                           prefersLargeTitle: false),
                    animated: true)
        }
        
    }
    
}

extension WorldClockViewController: AlarmClockViewDelegate {
    
    func deleteAlarm(at indexPath: IndexPath) {
        delete(at: indexPath)
    }
    
}

extension WorldClockViewController: AlarmUpdateDelegate {
    
    func update(with alarm: Alarm) {
//        alarms.append(alarm)
//        guard let dataSource = dataSource else {
//            return
//        }
//        var snapshot = dataSource.snapshot()
//        snapshot.appendItems([alarm], toSection: .other)
//        dataSource.apply(snapshot)
    }
    
}
