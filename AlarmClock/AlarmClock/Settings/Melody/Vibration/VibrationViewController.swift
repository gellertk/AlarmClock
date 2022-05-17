//
//  VibrationViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 17.05.2022.
//

import UIKit

fileprivate extension VibrationViewController {
    
    enum Section: CaseIterable {
        case synhronize
        case standart
        case user
        case no
        
        var headerTitle: String {
            switch self {
            case .synhronize, .no:
                return ""
            case .standart:
                return "СТАНДАРТНЫЕ"
            case .user:
                return "ПОЛЬЗОВАТЕЛЬСКИЕ"
            }
        }
    }
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, CellData>
    typealias CellRegistrationType = UICollectionView.CellRegistration<UICollectionViewListCell, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, CellData>
    
}

class VibrationViewController: UIViewController {
    
    private var alarm: Alarm?
    private var cellsData: [Section: [CellData]] = [:]
    private var dataSource: DataSourceType!
    
    private let vibrationView = VibrationView()
    
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
        title = "Мелодия"
        fillCells()
        setupDataSource()
    }

}

private extension VibrationViewController {
    
    func fillCells() {
        cellsData[.synhronize] = [CellData(cellType: .checkmark, text: "Синхронизировано (По умолчанию)", isCheckmarked: false)]
        cellsData[.standart] = K.String.defaultVibrations.map { CellData(cellType: .checkmark, text: $0) }
        cellsData[.user] = [CellData(cellType: .value, text: "Создать вибрацию")]
        cellsData[.no] = [CellData(cellType: .checkmark, text: "Не выбрана")]
    }
    
    func createCheckmarkCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            var configuration = UIListContentConfiguration.valueCell()
            configuration.text = item.text
            configuration.textProperties.numberOfLines = 1
            cell.contentConfiguration = configuration
            cell.tintColor = .systemOrange
            cell.accessories = [.checkmark()]
        }
    }
    
    func createValueCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            var configuration = UIListContentConfiguration.valueCell()
            configuration.text = item.text
            configuration.textProperties.numberOfLines = 1
            cell.contentConfiguration = configuration
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func setupDataSource() {
        let checkmarkCellRegistration = createCheckmarkCellRegistration()
        let valueCellRegistration = createValueCellRegistration()
        
        dataSource = DataSourceType(collectionView: vibrationView.collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier.cellType {
            case .checkmark:
                return collectionView.dequeueConfiguredReusableCell(using: checkmarkCellRegistration, for: indexPath, item: itemIdentifier)
            case .value:
                return collectionView.dequeueConfiguredReusableCell(using: valueCellRegistration, for: indexPath, item: itemIdentifier)
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
