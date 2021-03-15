//
//  UITableView + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import Foundation
import UIKit

extension UITableView {

    func reload() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func setup(
        delegate: UITableViewDelegate,
        dataSource: UITableViewDataSource,
        cells: [UITableViewCell.Type]
    ) {
        self.delegate   = delegate
        self.dataSource = dataSource
        
        cells.forEach { [weak self] cell in
            register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
        }
        
        self.reload()
    }
    
    func createCell(_ cell: UITableViewCell.Type,and indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: String(describing: cell.self), for: indexPath)
    }
    
    func createHeader(_ cell: UITableViewCell.Type) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cell.self))
    }
    
    func scrollDown(in section: Int) {
        let numberOfSections = self.numberOfSections
        let numberOfRows = self.numberOfRows(inSection: numberOfSections - 1)

        let indexPath = NSIndexPath(row: numberOfRows, section: section)
        self.scrollToRow(at: indexPath as IndexPath,
                                          at: UITableView.ScrollPosition.middle, animated: true)
    }
    
}
