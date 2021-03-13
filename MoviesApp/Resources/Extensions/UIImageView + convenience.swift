//
//  UIImageView + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func getImage(from url: String) {
        guard let urlImage = URL(string: url) else {
            debugPrint("The image can't be loaded, \(url) is not a valid URL")
            return
        }

        self.kf.setImage(with: urlImage)
    }
    
    
    
}
