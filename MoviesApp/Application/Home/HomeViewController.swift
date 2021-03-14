//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : HomeViewModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundBlack
        navigationBarSetup()
        tableView.backgroundColor = Colors.backgroundBlack
        tableView.setup(
            delegate: self,
            dataSource: self,
            cells: [
                PreviewTableViewCell.self,
                PreviewHeaderTableViewCell.self,
                SubscribedMoviesTableViewCell.self
            ]
        )
        setDataBridge()
        
    }
    
  
    
    func navigationBarSetup() {
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon"), style: .plain, target: self, action: #selector(presentSearchView))
        leftBarButton.tintColor = .white
        configNav(leftButton: leftBarButton, title: "TV Show Reminder")
    }
    
    
    @objc func presentSearchView() {
        if let movies = viewModel?.movies.value {
            let movieFinder = BaseNavigationController(rootViewController: MovieFinderViewController(movies: movies))
            self.present(movieFinder, animated: true)
        }
        
    }
    func setDataBridge() {
        viewModel = HomeViewModel()
        
        viewModel?.movies
            .subscribe(
                onNext: { [weak self] _ in
                    self?.tableView.reloadData()
                    
                }).disposed(by: disposeBag)
    }
    
    
    
    
    


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let scrollOffset = scrollView.contentOffset.y
            let contentSize  = scrollView.contentSize.height
            let scrollBottomOffset = scrollOffset + scrollView.frame.height

            if scrollBottomOffset * 1.3 > contentSize {
                    viewModel?.getNewPage()
            }
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let previewMovieHeader = tableView.createHeader(PreviewHeaderTableViewCell.self) as! PreviewHeaderTableViewCell
        previewMovieHeader.configHeader(with: viewModel?.sections[section].name() ?? "")
        return previewMovieHeader.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel?.sections[section] {
        case .AllMovies:
            return viewModel?.movies.value.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        switch viewModel?.sections[indexPath.section] {
        case .AllMovies:
            let previewMovieCell = tableView.createCell(PreviewTableViewCell.self, and: indexPath) as! PreviewTableViewCell
            if let movie = viewModel?.movies.value[indexPath.row] {
                previewMovieCell.configureCategory(movie: movie)
            }
            return previewMovieCell
            
        case .Subscripted:
            let subcribedMoviesCell = tableView.createCell(SubscribedMoviesTableViewCell.self, and: indexPath) as! SubscribedMoviesTableViewCell
            if let subscribedMovies = viewModel?.getSubscribedMovies() {
                subcribedMoviesCell.configureCell(with: subscribedMovies, delegate: self)
            }
            
            return subcribedMoviesCell
        case .none: return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel?.sections[indexPath.section] == .AllMovies else {
            return
        }
        guard let viewModel = viewModel?.getMovieDetailViewModel(index: indexPath.row) else {
            return
        }
        let vc = MovieDetailViewController(viewModel: viewModel, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension HomeViewController: MovieDetailViewControllerDelegate {
    func subscribeButtonPressed() {
        tableView.reloadData()
    }
}

extension HomeViewController: SubscribedMoviesTableViewCellDelegate {
    func openMovieDetail(with index: Int) {
        guard let viewModel = viewModel?.getMovieDetailViewModel(index: index, subscribed: true) else {return}
        let vc = MovieDetailViewController(viewModel: viewModel, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
