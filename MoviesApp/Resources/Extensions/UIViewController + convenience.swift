//
//  UIViewController + convenience.swift
//  MoviesApp
//
//  Created by Tarek on 17/03/2021.
//

import Foundation
import UIKit

extension UIViewController {
    static func topViewController() -> UIViewController {
        var vc = (UIApplication.shared.keyWindow?.rootViewController)!
        while vc.presentedViewController != nil {
            vc = vc.presentedViewController!
        }
        return vc
    }
    
    func showModally(animated: Bool = true) {
        let vc = UIViewController.topViewController()
        vc.present(self, animated: animated, completion: nil)
    }
    
    @IBAction func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
