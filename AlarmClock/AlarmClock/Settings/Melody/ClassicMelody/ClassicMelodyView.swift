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
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension ClassicMelodyView {
    
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
