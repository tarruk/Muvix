//
//  UIView + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit


extension UIView {
    
    func configUI(backgroundColor: UIColor, alpha: CGFloat? = nil, borderRadius: CGFloat? = nil) {
        self.backgroundColor = backgroundColor
        self.alpha = alpha ?? 1
        self.layer.cornerRadius = borderRadius ?? 0
    }
    
    func border(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func roundHalf(){
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func radius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
}
