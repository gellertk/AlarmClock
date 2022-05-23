//
//  AlarmClockView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class AlarmClockView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
//        tableView.register(AlarmClockTableViewCell.self, forCellReuseIdentifier: AlarmClockTableViewCell.reuseIdentifier)
//        tableView.backgroundColor = .black
//        tableView.separatorColor = K.Color.tableSeparator
//        tableView.separatorInset = .zero
//        tableView.layoutMargins = .zero
        collectionView.allowsSelection = false
        
        return collectionView
    }()
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
//        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
//        let layout =
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.headerMode = .supplementary
                        
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.1), heightDimension: .fractionalHeight(0.1))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                                           alignment: .topLeading)
            
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AlarmClockView {
    
    func setupView() {
        backgroundColor = .black
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
    }
    
}
