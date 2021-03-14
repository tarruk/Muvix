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

    
    var movies: [Movie] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var keyword: String?
    var filteredMovies: [Movie] {
        return movies.filter {
            ($0.orgTitle?.range(of: keyword ?? "", options: .caseInsensitive) != nil || keyword == nil || keyword == "")
        }
    }
    
    @IBOutlet weak var searchBarContainer: UIStackView!
    @IBOutlet weak var cleanSearchBarButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    init(movies: [Movie]) {
        super.init()
        self.movies = movies
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        tableView.setup(
            delegate: self,
            dataSource: self,
            cells: [MovieTableViewCell.self]
        )
        
        searchBarListener()
    }
    
    func configureViews() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        cleanSearchBarButton.setImage(#imageLiteral(resourceName: "close_icon").tint(with: Colors.cleanFilterBtn), for: [])  
        searchBarContainer.radius(3)
        searchBarContainer.backgroundColor = Colors.searchBarGray
        view.backgroundColor = Colors.backgroundBlack
        tableView.backgroundColor = Colors.backgroundBlack
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
    
    func searchBarListener() {
        self.searchBar
            .rx
            .text.distinctUntilChanged()
            .subscribe(
                onNext: { [weak self] text in
                    self?.keyword = text
                    if let text = text, text != "" {
                        self?.showCleanerButton()
                    } else {
                        self?.hideCleanerButton()
                    }
                    self?.tableView.reloadData()
                }).disposed(by: disposeBag)
    }

    
    @IBAction func cleanSearchBar(_ sender: Any) {
        self.searchBar.text = nil
        self.keyword = nil
        self.hideCleanerButton()
        self.tableView.reloadData()
    }
    
    @IBAction func cancelSearch(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension MovieFinderViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.createCell(MovieTableViewCell.self, and: indexPath) as! MovieTableViewCell
        movieCell.configureCell(movie: self.filteredMovies[indexPath.row], delegate: self)
        return movieCell
    }

    
}

extension MovieFinderViewController: MovieTableViewCellDelegate {
    
    func addButtonPressed(at cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        self.filteredMovies[indexPath.row]._added.toggle()
        tableView.reloadData()
    }
}
