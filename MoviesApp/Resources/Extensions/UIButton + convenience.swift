//
//  UIButton + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    
    func selectedCustom(title: String) {
        self.roundHalf()
        self.setTitle(title.uppercased(), for: .normal)
        self.setTitleColor(.clear, for: .normal)
        self.backgroundColor = .white
    }
    
    func unselectedCustom(title: String) {
        self.border(width: 2, color: .white)
        self.roundHalf()
        self.setTitle(title.uppercased(), for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .clear
    }
    
    
}
