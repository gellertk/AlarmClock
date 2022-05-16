//
//  AlarmMelodyView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

class MelodyView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return collectionView
    }()
    
//    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
//        let layout = UICollectionViewCompositionalLayout() { sectionIndex,  in 
//            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//            configuration.headerMode = .supplementary
//        }
////        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
////        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        return layout
//    }
        
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

