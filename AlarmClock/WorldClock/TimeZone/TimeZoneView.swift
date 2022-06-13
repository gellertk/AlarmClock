//
//  TimeZoneView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.02.2022.
//

import UIKit
import SnapKit

class TimeZoneView: UIView {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Поиск"
        if let cancelButton : UIButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
            cancelButton.setTitle("Отменить", for: .normal)
        }
        
        return searchBar
    }()
        
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension TimeZoneView {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.headerMode = .supplementary
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            
            return section
        }
        
        return layout
    }
    
    func setupView() {
        addSubview(collectionView)
    }
    
}


