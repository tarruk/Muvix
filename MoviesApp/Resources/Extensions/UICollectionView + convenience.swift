//
//  UICollectionView + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 14/03/2021.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func setup(
        delegate: UICollectionViewDelegateFlowLayout,
        dataSource: UICollectionViewDataSource,
        cells: [UICollectionViewCell.Type]
    ) {
        self.delegate   = delegate
        self.dataSource = dataSource
        
        cells.forEach { [weak self] cell in
            register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: cell.self))
        }
        
        self.reloadData()
    }
    
    func createCell(_ cell: UICollectionViewCell.Type,and indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cell.self), for: indexPath)
    }
    
}
