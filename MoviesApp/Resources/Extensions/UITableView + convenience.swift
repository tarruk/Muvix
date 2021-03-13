//
//  UITableView + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import Foundation
import UIKit

extension UITableView {

    func setup(
        delegate: UITableViewDelegate,
        dataSource: UITableViewDataSource,
        cells: [UITableViewCell.Type]
    ) {
        self.delegate   = delegate
        self.dataSource = dataSource
        
        cells.forEach { [weak self] cell in
            self?.register(cell.self, forCellReuseIdentifier: String(describing: cell.self))
        }
        
        self.reloadData()
    }
    
    func createCell(_ cell: UITableViewCell.Type,and indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: String(describing: cell.self), for: indexPath)
    }
    
    
}