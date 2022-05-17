//
//  AlarmMelodyViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

fileprivate extension MelodyViewController {
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<MelodyViewController.SectionType, CellData>
    typealias CellRegistrationType = UICollectionView.CellRegistration<UICollectionViewListCell, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<SectionType, CellData>
    
}

class MelodyViewController: UIViewController {
    
    enum SectionType: CaseIterable {
        case vibration
        case shop
        case songs
        case ringtones
        case no
        
        var headerTitle: String {
            switch self {
            case .shop:
                return "\nМАГАЗИН"
            case .songs:
                return "ПЕСНИ"
            case .ringtones:
                return "РИНГТОНЫ"
            case .vibration, .no:
                return ""
            }
        }
        
        var footerTitle: String {
            switch self {
            case .shop:
                return K.String.footerForShopSection
            default:
                return ""
            }
        }
        
    }
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?
    private var cellsData: [SectionType: [CellData]] = [:]
    private var dataSource: DataSourceType!
    private var settedCellIndexPath: IndexPath = IndexPath(item: 0, section: 4)
    
    private let melodyView = MelodyView()
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = melodyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мелодия"
        fillCells()
        setupDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let alarm = alarm else {
                return
            }
            delegate?.update(alarm: alarm)
        }
    }
    
}

private extension MelodyViewController {
    
    private func checkmarkConfiguration(isCheckmarkShown: Bool) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = "checkmark"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .headline)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        
        var cellAccessory = UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
        cellAccessory.isHidden = !isCheckmarkShown
        
        return cellAccessory
    }
    
    func createValueCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            var config = UIListContentConfiguration.valueCell()
            config.text = item.text
            config.secondaryText = item.secondaryText
            config.textProperties.numberOfLines = 1
            cell.contentConfiguration = config
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func createSystemCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            var config = UIListContentConfiguration.cell()
            config.text = item.text
            config.textProperties.numberOfLines = 1
            config.textProperties.color = .systemOrange
            cell.contentConfiguration = config
        }
    }
    
    func createLeftCheckmarkCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { [weak self] cell, indexPath, item in
            guard let self = self else {
                return
            }
            let section = SectionType.allCases[indexPath.section]
            let isCheckmarked = self.cellsData[section]?[indexPath.row].isChekmarked ?? false
            var config = UIListContentConfiguration.cell()
            config.text = item.text
            config.textProperties.numberOfLines = 1
            cell.contentConfiguration = config
            var checkmark = self.checkmarkConfiguration(isCheckmarkShown: isCheckmarked)
            checkmark.tintColor = .systemOrange
            cell.accessories = [.customView(configuration: checkmark)]
        }
    }
    
    func createLeftCheckmarkWitchDisclosureCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { [weak self] cell, _, item in
            guard let self = self else {
                return
            }
            var config = UIListContentConfiguration.cell()
            config.text = item.text
            config.textProperties.numberOfLines = 1
            cell.contentConfiguration = config
            var checkmark = self.checkmarkConfiguration(isCheckmarkShown: item.isChekmarked)
            checkmark.tintColor = .systemOrange
            cell.accessories = [.customView(configuration: checkmark), .disclosureIndicator()]
        }
    }
    
    func setupDataSource() {
        let valueRegistration = createValueCellRegistration()
        let systemRegistration = createSystemCellRegistration()
        let leftCheckmarkRegistration = createLeftCheckmarkCellRegistration()
        let leftCheckmarkWithDisclosureRegistration = createLeftCheckmarkWitchDisclosureCellRegistration()
        
        dataSource = DataSourceType(collectionView: melodyView.collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier.cellType {
            case .value:
                return collectionView.dequeueConfiguredReusableCell(using: valueRegistration, for: indexPath, item: itemIdentifier)
            case .system:
                return collectionView.dequeueConfiguredReusableCell(using: systemRegistration, for: indexPath, item: itemIdentifier)
            case .leftCheckmark:
                return collectionView.dequeueConfiguredReusableCell(using: leftCheckmarkRegistration, for: indexPath, item: itemIdentifier)
            case .leftCheckmarkWithDisclosure:
                return collectionView.dequeueConfiguredReusableCell(using: leftCheckmarkWithDisclosureRegistration, for: indexPath, item: itemIdentifier)
            default:
                return nil
            }
        }
        
        setupHeader()
        
        var snapshot = SnapshotType()
        for section in SectionType.allCases {
            snapshot.appendSections([section])
            snapshot.appendItems(cellsData[section] ?? [])
        }
        dataSource.apply(snapshot)
        
        melodyView.collectionView.delegate = self
    }
    
    func setupHeader() {
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionHeader) {
            (cell: UICollectionViewListCell, _, indexPath) in
            
            var configuration = cell.defaultContentConfiguration()
            configuration.text = SectionType.allCases[indexPath.section].headerTitle
            
            cell.contentConfiguration = configuration
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionFooter) {
            (cell: UICollectionViewListCell, _, indexPath) in
            let section = SectionType.allCases[indexPath.section]
            var configuration = cell.defaultContentConfiguration()
            configuration.text = section.footerTitle
            configuration.textProperties.font = configuration.textProperties.font.withSize(configuration.textProperties.font.pointSize - 0.3)
            cell.contentConfiguration = configuration
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
        
            return collectionView.dequeueConfiguredReusableSupplementary(using: kind == UICollectionView.elementKindSectionHeader ?
                                                                         headerRegistration : footerRegistration, for: indexPath)
        }
        
    }
    
    func fillCells() {
        cellsData = [
                .vibration: [CellData(cellType: .value,
                                  text: "Вибрация",
                                  secondaryText: alarm?.vibration?.title ?? "Не выбрана") { [weak self] in self?.toVibrationVC() }],
            
                .shop: [CellData(cellType: .system, text: "Магазин звуков") { [weak self] in self?.toVibrationVC() },
                        CellData(cellType: .system, text: "Загрузить купленные звуки") { [weak self] in self?.toVibrationVC() }],
            
                .songs: [CellData(cellType: .leftCheckmark, text: "Пение птиц Весной (Звуки Природы)"),
                         CellData(cellType: .leftCheckmarkWithDisclosure, text: "Выбор песни") { [weak self] in self?.toAppleMusic() }]
        ]
        
        var ringtonesCell = K.String.defaultRingtones.map { CellData(cellType: .leftCheckmark, text: $0) }
        ringtonesCell.append(CellData(cellType: .leftCheckmarkWithDisclosure, text: "Классические") { [weak self] in self?.toVibrationVC() })
        
        cellsData[.ringtones] = ringtonesCell
        cellsData[.no] = [CellData(cellType: .leftCheckmark, text: "Нет")]
    }
    
    func toVibrationVC() {
        guard let alarm = alarm else {
            return
        }
        let vibrationVC = VibrationViewController(alarm: alarm)
        navigationController?.pushViewController(vibrationVC, animated: true)
    }
    
    func toAppleMusic() {
        let urlString = "music://music.apple.com/browse"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension MelodyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionType.allCases[indexPath.section]
        guard let cellData = cellsData[section]?[indexPath.row] else {
            return
        }
        if cellData.cellType == .leftCheckmark {
            let removableSection = SectionType.allCases[settedCellIndexPath.section]
            cellsData[removableSection]?[settedCellIndexPath.row].isChekmarked = false
            cellsData[section]?[indexPath.row].isChekmarked = true
            var newSnapshot = dataSource.snapshot()
            guard let removableCell = cellsData[removableSection]?[settedCellIndexPath.row],
                  let settedCell = cellsData[section]?[indexPath.row] else {
                return
            }
            newSnapshot.reconfigureItems([removableCell, settedCell])
            dataSource.apply(newSnapshot, animatingDifferences: false)
            settedCellIndexPath = indexPath
        }
        
        cellData.handler?()
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
