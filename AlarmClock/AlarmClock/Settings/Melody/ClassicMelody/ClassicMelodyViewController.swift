//
//  ClassicMelodysViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 21.05.2022.
//

import UIKit

fileprivate extension ClassicMelodyViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, CellData>
    typealias LeadingCheckmarkCellRegistrationType = UICollectionView.CellRegistration<LeadingCheckmarkListCell, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, CellData>
    
}

class ClassicMelodyViewController: UIViewController {
    
    private var alarm: Alarm?
    private var cellsData: [Section: [CellData]] = [:]
    private var dataSource: DataSourceType!
    private var lastCheckmarkedIndexPath: IndexPath?
    
    private let classicMelodyView = ClassicMelodyView()
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = classicMelodyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Классические"
        fillCells()
        setupDataSource()
    }
    
}

private extension ClassicMelodyViewController {
    
    func fillCells() {
        cellsData[.main] = K.String.classicMelodys.map { CellData(cellType: .leadingCheckmark, text: $0) }
    }
    
    func createLeadingCheckmarkCellRegistration() -> LeadingCheckmarkCellRegistrationType {
        return LeadingCheckmarkCellRegistrationType() { cell, _, item in
            cell.configure(with: item.text, isCheckmarked: item.isCheckmarked)
        }
    }
    
    func setupDataSource() {
        classicMelodyView.collectionView.delegate = self
        
        let leadingCheckmarkCellRegistration = createLeadingCheckmarkCellRegistration()
        
        dataSource = DataSourceType(collectionView: classicMelodyView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: leadingCheckmarkCellRegistration,
                                                                for: indexPath,
                                                                item: itemIdentifier)
        }
        
        var snapshot = SnapshotType()
        Section.allCases.forEach {
            if let cells = cellsData[$0]  {
                snapshot.appendSections([$0])
                snapshot.appendItems(cells)
            }
        }
        dataSource.apply(snapshot)
    }
    
}

extension ClassicMelodyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        guard let sectionCells = cellsData[section] else {
            return
        }
        let currentCell = sectionCells[indexPath.row]
        var newSnapshot = dataSource.snapshot()
        if !currentCell.isCheckmarked {
            currentCell.isCheckmarked = true
            if let lastCheckmarkedIndexPath = lastCheckmarkedIndexPath {
                let uncheckmarkedCell = sectionCells[lastCheckmarkedIndexPath.row]
                uncheckmarkedCell.isCheckmarked = false
                newSnapshot.reconfigureItems([uncheckmarkedCell, currentCell])
            } else {
                newSnapshot.reconfigureItems([currentCell])
            }
            lastCheckmarkedIndexPath = indexPath
        }
        dataSource.apply(newSnapshot, animatingDifferences: false)
        
        currentCell.handler?()
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
