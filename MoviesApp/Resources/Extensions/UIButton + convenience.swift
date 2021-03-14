//
//  UIButton + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    
    func subscribedCustom(title: String, titleColor: UIColor) {
        self.roundHalf()
        self.setTitle(title.uppercased(), for: [])
        self.setTitleColor(titleColor, for: [])
        self.backgroundColor = .white
    }
    
    func unsubscribedCustom(title: String) {
        self.border(width: 2, color: .white)
        self.roundHalf()
        self.setTitle(title.uppercased(), for: [])
        self.setTitleColor(.white, for: [])
        self.backgroundColor = .clear
    }
    
    func addedCustom(title: String, titleColor: UIColor) {
        self.radius(3)
        self.setTitle(title.uppercased(), for: [])
        self.setTitleColor(titleColor, for: [])
        self.backgroundColor = .white
        self.alpha = 0.30
    }
    
    func noAddedCustom(title: String) {
        self.border(width: 2, color: .white)
        self.radius(3)
        self.setTitle(title.uppercased(), for: [])
        self.setTitleColor(.white, for: [])
        self.backgroundColor = .clear
        self.alpha = 0.30
    }
    
    
    
    
    
}
