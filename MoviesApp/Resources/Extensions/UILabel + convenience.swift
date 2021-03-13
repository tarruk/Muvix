//
//  UILabel + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit

extension UILabel {
    
    func configure(text: String, color: UIColor, font: UIFont, alignment: NSTextAlignment? = nil, alpha: CGFloat? = nil ){
        self.text       = text
        self.textColor  = color
        self.font       = font
        if let alpha = alpha {
            self.alpha = alpha
        }
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        
        
    }
}
