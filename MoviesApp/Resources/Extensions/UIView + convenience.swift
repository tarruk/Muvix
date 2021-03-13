//
//  UIView + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit


struct BorderView {
    var width: CGFloat
    var color: CGColor
}

extension UIView {
    
    func configUI(backgroundColor: UIColor, alpha: CGFloat? = nil, borderRadius: CGFloat? = nil, border: BorderView? = nil) {
        self.backgroundColor = backgroundColor
        self.alpha = alpha ?? 1
        self.layer.cornerRadius = borderRadius ?? 0
        
        if let border = border {
            self.layer.borderWidth = border.width
            self.layer.borderColor = border.color
            
        }
    }
    
    func border(width: CGFloat, color: UIColor) -> BorderView {
        return BorderView(width: width, color: color.cgColor)
    }
    
    func roundHalf(){
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func radius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
}
