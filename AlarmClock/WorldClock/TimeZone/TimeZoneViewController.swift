//
//  TimeZoneViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.02.2022.
//

import UIKit
import SnapKit

class TimeZoneViewController: UIViewController {
    
    typealias CustomCellRegistrationType = UICollectionView.CellRegistration<DefaultListCell, String>
    typealias DataSourceType = UICollectionViewDiffableDataSource<String, String>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<String, String>
    
    private let mainView = TimeZoneView()
    
    private var dataSource: DataSourceType?
    private var systemWorldClock: [String: [String]] = WorldClock.getSystemWorldClock()
    private var systemWorldClockKeys: [String] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбрать город"
        setupDataSource()
        applySnapshot()
        setupNavigationBar()
    }
    
}

extension TimeZoneViewController {
    
    func createCellRegistration() -> CustomCellRegistrationType {
        return CustomCellRegistrationType() { cell, indexPath, item in
            
            cell.configure(text: item)
            cell.contentView.backgroundColor = .customBlack
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
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionHeader) { [weak self]
            (cell: UICollectionViewListCell, _, indexPath) in
            
            var configuration = cell.defaultContentConfiguration()
            configuration.text = self?.systemWorldClockKeys[indexPath.section]
            cell.contentConfiguration = configuration
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                         for: indexPath)
        }
        
    }
    
    func applySnapshot() {
        var snapshot = SnapshotType()
        systemWorldClockKeys = Array(systemWorldClock.map({ $0.key })).sorted()
        
        for item in systemWorldClock.sorted(by: { $0.key < $1.key }) {
            snapshot.appendSections([item.key])
            snapshot.appendItems(item.value)
        }
        
        dataSource?.apply(snapshot)
    }
    
    func setupNavigationBar() {
        let label = UILabel()
        label.text = "Выбрать город"
        let navigationView = UIView()
        navigationView.addSubview(mainView.searchBar)
        navigationView.addSubview(label)
        navigationItem.titleView = navigationView
//        let leftNavBarButton = UIBarButtonItem(customView: mainView.searchBar)
//        navigationItem.leftBarButtonItem = leftNavBarButton

//        navigationItem.titleView = label
//        navigationItem.title = "Выбрать город"
    }
    
}

extension TimeZoneViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
    
    
}
