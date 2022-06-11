//
//  ClassicMelodyView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 21.05.2022.
//

import UIKit

class ClassicMelodyView: UIView {

    lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
