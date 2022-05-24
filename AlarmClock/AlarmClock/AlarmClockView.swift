//
//  AlarmClockView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class AlarmClockView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.allowsSelection = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //collectionView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        
        return collectionView
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.headerMode = .supplementary
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
//            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                    heightDimension: .estimated(100))
//
//            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
//                                                                           elementKind: UICollectionView.elementKindSectionHeader,
//                                                                            alignment: .top)

            //section.boundarySupplementaryItems = [sectionHeader]
            
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
        overrideUserInterfaceStyle = .dark
        backgroundColor = K.Color.disabledBackground
        addSubview(collectionView)
    }
    
}
