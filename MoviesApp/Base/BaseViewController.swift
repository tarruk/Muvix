//
//  BaseViewController.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarTransparent()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        
        
    }
    
    func configNav(leftButton: UIBarButtonItem, title: String? = nil) {
        self.navigationItem.leftBarButtonItems = [leftButton]
        if let title = title {
            self.navigationItem.titleView = self.createLabelView(title: title)
        }
        
        
    }
    
    
    func createLabelView(title: String) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width - 100), height: 40))
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.configure(text: title, color: .white, font: Fonts.SwanSea.bold.sized(17))
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width - 100), height: 40))
//        newView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 20)
        newView.addSubview(label)
        navigationItem.titleView?.contentMode = .right
        
        return newView
    }
    
    
    
    
}
