//
//  BaseViewComponent.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit
class BaseViewComponent: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        self.frame = bounds
        contentView.frame = bounds
        
        self.addSubview(contentView)
    }
}
