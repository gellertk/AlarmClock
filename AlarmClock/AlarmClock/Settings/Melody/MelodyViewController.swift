//
//  AlarmMelodyViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

fileprivate extension MelodyViewController {
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, CellData>
    
}

class MelodyViewController: UIViewController {
    
    enum Section: CaseIterable {
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
    private var cellsData: [Section: [CellData]] = [:]
    private var dataSource: DataSourceType!
    private var lastCheckmarkedCellIndexPath: IndexPath?
    private var sectionCheckmarkedCellIndexPath: IndexPath?
    
    private let melodyView = MelodyView()
    private let ringtones = Melody.getRingtones()
    private let songs = Melody.getSongs()
    
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
            delegate?.update(with: alarm)
        }
    }
    
}

private extension MelodyViewController {
    
    func createValueCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            cell.configure(text: item.text, secondaryText: item.secondaryText)
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func createSystemCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            cell.configure(text: item.text, textColor: .systemOrange)
        }
    }
    
    func createLeadingCheckmarkCellRegistration() -> LeadingCheckmarkCellRegistrationType {
        return LeadingCheckmarkCellRegistrationType() { cell, _, item in
            cell.configure(with: item.text, isCheckmarked: item.isCheckmarked)
        }
    }
    
    func createLeadingChekmarkWithDisclosureCellRegistration() -> LeadingCheckmarkCellRegistrationType {
        return LeadingCheckmarkCellRegistrationType() { cell, _, item in
            cell.configure(with: item.text, isCheckmarked: item.isCheckmarked)
            cell.accessories.append(.disclosureIndicator())
        }
    }
    
    func setupDataSource() {
        let valueRegistration = createValueCellRegistration()
        let systemRegistration = createSystemCellRegistration()
        let leadingCheckmarkRegistration = createLeadingCheckmarkCellRegistration()
        let leadingCheckmarkWithDisclosureRegistration = createLeadingChekmarkWithDisclosureCellRegistration()
        
        dataSource = DataSourceType(collectionView: melodyView.collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier.cellType {
            case .value:
                return collectionView.dequeueConfiguredReusableCell(using: valueRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            case .system:
                return collectionView.dequeueConfiguredReusableCell(using: systemRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            case .leadingCheckmark:
                return collectionView.dequeueConfiguredReusableCell(using: leadingCheckmarkRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            case .leadingCheckmarkWithDisclosure:
                return collectionView.dequeueConfiguredReusableCell(using: leadingCheckmarkWithDisclosureRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            default:
                return nil
            }
        }
        
        setupHeader()
        
        var snapshot = SnapshotType()
        for section in Section.allCases {
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
            configuration.text = Section.allCases[indexPath.section].headerTitle
            cell.contentConfiguration = configuration
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionFooter) {
            (cell: UICollectionViewListCell, _, indexPath) in
            let section = Section.allCases[indexPath.section]
            var configuration = cell.defaultContentConfiguration()
            configuration.text = section.footerTitle
            configuration.textProperties.font =
            configuration.textProperties.font.withSize(configuration.textProperties.font.pointSize - 0.3)
            cell.contentConfiguration = configuration
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            
            return collectionView.dequeueConfiguredReusableSupplementary(using: kind == UICollectionView.elementKindSectionHeader ?
                                                                         headerRegistration : footerRegistration,
                                                                         for: indexPath)
        }
        
    }
    
    func fillCells() {
        cellsData = [
            .vibration: [CellData(cellType: .value,
                                  text: "Вибрация",
                                  secondaryText: alarm?.vibration?.title ?? "Не выбрана") {
                                      [weak self] in self?.toVibrationVC()
                                  }],
            
                .shop: [CellData(cellType: .system, text: "Магазин звуков"),
                        CellData(cellType: .system, text: "Загрузить купленные звуки")]
        ]
        
        cellsData[.songs] = []
        for (index, song) in songs.enumerated() {
            if song == alarm?.melody,
               let sectionIndex = Section.allCases.firstIndex(of: .songs) {
                lastCheckmarkedCellIndexPath = IndexPath(item: index, section: sectionIndex)
            }
            cellsData[.songs]?.append(CellData(cellType: .leadingCheckmark,
                                               text: song.title,
                                               isCheckmarked: alarm?.melody?.title == song.title))
        }
        cellsData[.songs]?.append(CellData(cellType: .leadingCheckmarkWithDisclosure, text: "Выбор песни") {
            [weak self] in self?.toAppleMusic()
        })
        
        //RINGTONES
        cellsData[.ringtones] = []
        for (index, melody) in ringtones.enumerated() {
            if let sectionIndex = Section.allCases.firstIndex(of: .ringtones),
               melody == alarm?.melody {
                lastCheckmarkedCellIndexPath = IndexPath(item: index, section: sectionIndex)
            }
            cellsData[.ringtones]?.append(CellData(cellType: .leadingCheckmark,
                                                   text: melody.title,
                                                   isCheckmarked: alarm?.melody == melody))
        }
        
        cellsData[.ringtones]?.append(CellData(cellType: .leadingCheckmarkWithDisclosure,
                                               text: "Классические",
                                               isCheckmarked: alarm?.melody?.type == .classicRingtone) {
            [weak self] in self?.toClassicMelodyVC()
        })
        if alarm?.melody?.type == .classicRingtone,
           let sectionIndex = Section.allCases.firstIndex(of: .ringtones) {
            lastCheckmarkedCellIndexPath = IndexPath(item: ringtones.count, section: sectionIndex)
        }
        
        //NO
        cellsData[.no] = [CellData(cellType: .leadingCheckmark, text: "Нет", isCheckmarked: alarm?.melody == nil)]
        if let sectionIndex = Section.allCases.firstIndex(of: .no),
           alarm?.melody == nil {
            lastCheckmarkedCellIndexPath = IndexPath(item: 0, section: sectionIndex)
        }
    }
    
    func toVibrationVC() {
        guard let alarm = alarm else {
            return
        }
        let vibrationVC = VibrationViewController(alarm: alarm)
        vibrationVC.delegate = self
        navigationController?.pushViewController(vibrationVC, animated: true)
    }
    
    func toClassicMelodyVC() {
        guard let alarm = alarm else {
            return
        }
        let classicMelodysVC = ClassicMelodyViewController(alarm: alarm)
        classicMelodysVC.delegate = self
        navigationController?.pushViewController(classicMelodysVC, animated: true)
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
        let section = Section.allCases[indexPath.section]
        guard let sectionCells = cellsData[section] else {
            return
        }
        let currentCell = sectionCells[indexPath.row]
        var newSnapshot = dataSource.snapshot()
        if !currentCell.isCheckmarked, currentCell.cellType == .leadingCheckmark {
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
            if let ringtone = ringtones.first(where: { $0.title == currentCell.text }) {
                alarm?.melody = ringtone
            } else {
                alarm?.melody = songs.first { $0.title == currentCell.text }
            }
        }
        dataSource.apply(newSnapshot, animatingDifferences: false)
        currentCell.handler?()
        
        sectionCheckmarkedCellIndexPath = indexPath
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension MelodyViewController: AlarmUpdateDelegate {
    
    func update(with alarm: Alarm) {
        if self.alarm?.melody != alarm.melody {
            guard let uncheckmarkedIndexPath = lastCheckmarkedCellIndexPath,
                  let checkmarkedIndexPath = sectionCheckmarkedCellIndexPath else {
                return
            }
            let uncheckmarkedSection = Section.allCases[uncheckmarkedIndexPath.section]
            let checkmarkedSection = Section.allCases[checkmarkedIndexPath.section]
            
            if let uncheckmarkedCell = cellsData[uncheckmarkedSection]?[uncheckmarkedIndexPath.row],
               let checkmarkedCell = cellsData[checkmarkedSection]?[checkmarkedIndexPath.row],
               uncheckmarkedCell != checkmarkedCell {
                uncheckmarkedCell.isCheckmarked = false
                checkmarkedCell.isCheckmarked = true
                updateSnapshot(with: [uncheckmarkedCell, checkmarkedCell])
                lastCheckmarkedCellIndexPath = sectionCheckmarkedCellIndexPath
            }
        } else if self.alarm?.vibration != alarm.vibration {
            guard let updatedIndexPath = sectionCheckmarkedCellIndexPath else {
                return
            }
            let updatedSection = Section.allCases[updatedIndexPath.section]
            
            if let updatedCell = cellsData[updatedSection]?[updatedIndexPath.row] {
                updatedCell.secondaryText = alarm.vibration?.title ?? "Не выбрана"
                updateSnapshot(with: [updatedCell])
                lastCheckmarkedCellIndexPath = sectionCheckmarkedCellIndexPath
            }
        }
        
        self.alarm = alarm
    }
    
    func updateSnapshot(with updatedCells: [CellData]) {
        var newSnapshot = dataSource.snapshot()
        newSnapshot.reconfigureItems(updatedCells)
        dataSource.apply(newSnapshot, animatingDifferences: false)
    }
    
}
