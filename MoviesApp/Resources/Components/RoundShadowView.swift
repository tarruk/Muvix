//
//  RoundShadowView.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import Foundation
import UIKit

final class RoundShadowView: UIView {
  
    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2.0)
    @IBInspectable var shadowOpacity: Float = 0.2
    @IBInspectable var shadowRadius: CGFloat = 13
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // set the shadow of the view's layer
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        
        // set the cornerRadius of the containerView's layer
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
    

    
}
