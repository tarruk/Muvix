//
//  UIButton + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    
    func subscribedCustom(title: String? = nil, titleColor: UIColor, radius: CGFloat? = nil, alpha: CGFloat? = nil) {
        self.setTitle(title?.uppercased() ?? "SUSCRIPTO", for: [])
        self.setTitleColor(titleColor, for: [])
        self.backgroundColor = .white
        if let radius = radius {
            self.layer.cornerRadius = radius
        } else {
            self.roundHalf()
        }
        self.alpha = alpha ?? 1
    }
    
    func unsubscribedCustom(title: String? = nil, radius: CGFloat? = nil, alpha: CGFloat? = nil) {
        self.border(width: 2, color: .white)
        self.setTitle(title?.uppercased() ?? "SUSCRIBIRME", for: [])
        self.setTitleColor(.white, for: [])
        self.backgroundColor = .clear
        if let radius = radius {
            self.layer.cornerRadius = radius
        } else {
            self.roundHalf()
        }
        self.alpha = alpha ?? 1
    }
    
}
