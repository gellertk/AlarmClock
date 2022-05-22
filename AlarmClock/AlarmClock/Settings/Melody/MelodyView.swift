//
//  AlarmMelodyView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

class MelodyView: UIView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.headerMode = .supplementary
            configuration.footerMode = .supplementary
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            
            return section
        }
        
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MelodyView {
    
    func setupView() {
        overrideUserInterfaceStyle = .dark
        backgroundColor = K.Color.disabledBackground
        [collectionView].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

