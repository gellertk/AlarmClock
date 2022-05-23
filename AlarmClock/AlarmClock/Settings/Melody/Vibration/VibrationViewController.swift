//
//  VibrationViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 17.05.2022.
//

import UIKit

fileprivate extension VibrationViewController {
    
    enum Section: CaseIterable {
        //case synhronize
        case standart
        case user
        case no
        
        var headerTitle: String {
            switch self {
//            case .synhronize:
//                return "\n"
            case .standart:
                return "\nСТАНДАРТНЫЕ"
            case .user:
                return "ПОЛЬЗОВАТЕЛЬСКИЕ"
            case .no:
                return ""
            }
        }
    }
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, CellData>
    
}

class VibrationViewController: UIViewController {
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?
    private var cellsData: [Section: [CellData]] = [:]
    private var dataSource: DataSourceType!
    private var lastCheckmarkedCellIndexPath: IndexPath?
    
    private let vibrationView = VibrationView()
    private let vibrations = Vibration.getDefaultVibrations()
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = vibrationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Вибрация"
        fillCells()
        setupDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let alarm = alarm else {
                return
            }
            delegate?.update(with: alarm)
        }
    }

}

private extension VibrationViewController {
    
    func fillCells() {
        cellsData[.standart] = []
        for (index, vibration) in vibrations.enumerated() {
            if let sectionIndex = Section.allCases.firstIndex(of: .standart),
               vibration == alarm?.vibration {
                lastCheckmarkedCellIndexPath = IndexPath(item: index, section: sectionIndex)
            }
            cellsData[.standart]?.append(CellData(cellType: .checkmark,
                                                   text: vibration.title,
                                                   isCheckmarked: alarm?.vibration == vibration))
        }
        cellsData[.user] = [CellData(cellType: .value, text: "Создать вибрацию")]
        cellsData[.no] = [CellData(cellType: .checkmark, text: "Не выбрана", isCheckmarked: alarm?.vibration == nil)]
        if let sectionIndex = Section.allCases.firstIndex(of: .no),
           alarm?.vibration == nil {
            lastCheckmarkedCellIndexPath = IndexPath(item: 0, section: sectionIndex)
        }
    }
    
    func createCheckmarkCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            cell.configure(text: item.text)
            cell.accessories = item.isCheckmarked ? [.checkmark()] : []
        }
    }
    
    func createValueCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            cell.configure(text: item.text)
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func setupDataSource() {
        let checkmarkCellRegistration = createCheckmarkCellRegistration()
        let valueCellRegistration = createValueCellRegistration()
        
        dataSource = DataSourceType(collectionView: vibrationView.collectionView) {
            collectionView, indexPath, itemIdentifier in
            switch itemIdentifier.cellType {
            case .checkmark:
                return collectionView.dequeueConfiguredReusableCell(using: checkmarkCellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            case .value:
                return collectionView.dequeueConfiguredReusableCell(using: valueCellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            default:
                return nil
            }
        }
        
        setupHeader()
        
        var snapshot = SnapshotType()
        Section.allCases.forEach {
            if let cells = cellsData[$0]  {
                snapshot.appendSections([$0])
                snapshot.appendItems(cells)
            }
        }
        dataSource.apply(snapshot)
        vibrationView.collectionView.delegate = self
    }
    
    func setupHeader() {
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionHeader) { (cell: UICollectionViewListCell, elementKind, indexPath) in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = Section.allCases[indexPath.section].headerTitle
            
            cell.contentConfiguration = configuration
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in
            
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
    }
    
}

extension VibrationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        guard let sectionCells = cellsData[section] else {
            return
        }
        let currentCell = sectionCells[indexPath.row]
        var newSnapshot = dataSource.snapshot()
        if !currentCell.isCheckmarked, currentCell.cellType == .checkmark {
            currentCell.isCheckmarked = true
            if let lastCheckmarkedIndexPath = lastCheckmarkedCellIndexPath {
                let uncheckmarkedSection = Section.allCases[lastCheckmarkedIndexPath.section]
                if let uncheckmarkedCell = cellsData[uncheckmarkedSection]?[lastCheckmarkedIndexPath.row] {
                    uncheckmarkedCell.isCheckmarked = false
                    newSnapshot.reconfigureItems([uncheckmarkedCell, currentCell])
                }
            } else {
                newSnapshot.reconfigureItems([currentCell])
            }
            lastCheckmarkedCellIndexPath = indexPath
            alarm?.vibration = vibrations.first { $0.title == currentCell.text }
        }
        dataSource.apply(newSnapshot, animatingDifferences: false)
        
        currentCell.handler?()
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
