//
//  UINavigationController + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import Foundation
import UIKit




extension UINavigationController {
    
    func navigationBarSetup(buttons: [UIBarButtonItem])
}

class TVBarButtonItem: UIBarButtonItem {
    
    
    convenience init(image: UIImage, target: AnyObject, action: Selector) {
        self.init(image: image, target: target, action: action)
    }
    
    required init?(coder: NSCoder) {
        super.init()
        
    }
    
    
    
}
