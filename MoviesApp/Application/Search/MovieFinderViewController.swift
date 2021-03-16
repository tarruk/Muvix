//
//  MovieFinderViewController.swift
//  MoviesApp
//
//  Created by Tarek on 14/03/2021.
//

import UIKit
import RxSwift
import RxCocoa
class MovieFinderViewController: BaseViewController {
    
    @IBOutlet weak var searchBarContainer: UIStackView!
    @IBOutlet weak var cleanSearchBarButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MovieFinderViewModel
    
    init(movies: [Movie]) {
        viewModel = MovieFinderViewModel(movies: movies)
        super.init()
        
    }
    
    deinit {
        debugPrint("Closing MovieFinder")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        searchBarListener()
        notificationsListener()
    }
    
    func notificationsListener() {
        NotificationCenter.default.addObserver(forName: .updateSubscribedMovies, object: nil, queue: nil) { (_) in
            self.tableView.reload()
        }
    }
    
    func configureViews() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        cleanSearchBarButton.setImage(#imageLiteral(resourceName: "close_icon").tint(with: Colors.cleanFilterBtn), for: [])  
        searchBarContainer.radius(3)
        searchBarContainer.backgroundColor = Colors.searchBarGray
        view.backgroundColor = Colors.backgroundBlack
        tableView.backgroundColor = Colors.backgroundBlack
        tableView.setup(
            delegate: self,
            dataSource: self,
            cells: [MovieTableViewCell.self]
        )
    }
    
    
    func hideCleanerButton(){
        cleanSearchBarButton.alpha = 1
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.cleanSearchBarButton.alpha = 0
            self.cleanSearchBarButton.isHidden = true
            self.cleanSearchBarButton.transform = CGAffineTransform(translationX: 100, y: 0)
        })
        
    }
    func showCleanerButton(){
        self.cleanSearchBarButton.isHidden = false
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.cleanSearchBarButton.transform = .identity
            self.cleanSearchBarButton.alpha = 1
        })
        
        
    }
    
    func bindKeyword(with text: String) {
        viewModel.keyword = text
        if text != "" {
            showCleanerButton()
        } else {
            hideCleanerButton()
        }
    }
    
    func searchBarListener() {
        self.searchBar
            .rx
            .text.distinctUntilChanged()
            .subscribe(
                onNext: { [weak self] text in
                    guard let text = text else { return }
                    self?.bindKeyword(with: text)
                    self?.tableView.reload()
                }).disposed(by: disposeBag)
    }

    
    @IBAction func cleanSearchBar(_ sender: Any) {
        searchBar.text = nil
        hideCleanerButton()
        tableView.reload()
    }
    
    @IBAction func cancelSearch(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension MovieFinderViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.createCell(MovieTableViewCell.self, and: indexPath) as! MovieTableViewCell
        movieCell.configureCell(movie: viewModel.filteredMovies[indexPath.row])
        return movieCell
    }
 
    
}

