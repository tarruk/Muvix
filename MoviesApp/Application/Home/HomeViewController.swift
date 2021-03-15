//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var scrollTopButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    let viewModel: HomeViewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        navigationBarSetup()
        setDataBridge()
        notificationsListener()
    }
    
    func configureViews() {
        scrollTopButton.isHidden = true
        view.backgroundColor = Colors.backgroundBlack
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
    }
    
    func navigationBarSetup() {
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon"), style: .plain, target: self, action: #selector(presentSearchView))
        leftBarButton.tintColor = .white
        configNav(leftButton: leftBarButton, title: "TV Show Reminder")
    }
    
    @objc func presentSearchView() {
        let movieFinderVc = BaseNavigationController(rootViewController: MovieFinderViewController(movies: viewModel.getAllMovies()))
        self.present(movieFinderVc, animated: true)
    }
    
    func setDataBridge() {
        viewModel.movies
            .subscribe(
                onNext: { [weak self] _ in
                    self?.tableView.reload()
                    
                }).disposed(by: disposeBag)
    }
    
    func notificationsListener() {
        NotificationCenter.default.addObserver(forName: .updateSubscribedMovies, object: nil, queue: nil) { (_) in
            self.tableView.reload()
        }
    }
    
    
    
    @IBAction func scrollToTop(_ sender: Any) {
       self.tableView.contentOffset.y = 0
       
    }
    
    


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 1) {
                self.scrollTopButton.isHidden = false
                self.scrollTopButton.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.scrollTopButton.alpha = 0
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let scrollOffset = scrollView.contentOffset.y
            let contentSize  = scrollView.contentSize.height
            let scrollBottomOffset = scrollOffset + scrollView.frame.height

            if scrollBottomOffset * 1.3 > contentSize {
                    viewModel.getNewPage()
            }
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let previewMovieHeader = tableView.createHeader(PreviewHeaderTableViewCell.self) as! PreviewHeaderTableViewCell
        previewMovieHeader.configureHeader(with: viewModel.sections[section].name())
        return previewMovieHeader.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .AllMovies:
            return viewModel.movies.value.count
        case .Subscripted:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .AllMovies:
            let previewMovieCell = tableView.createCell(PreviewTableViewCell.self, and: indexPath) as! PreviewTableViewCell
            let movie = viewModel.getMovie(at: indexPath.row)
            previewMovieCell.configureCell(with: movie)
            return previewMovieCell
        case .Subscripted:
            let subcribedMoviesCell = tableView.createCell(SubscribedMoviesTableViewCell.self, and: indexPath) as! SubscribedMoviesTableViewCell
            let subscribedMovies = viewModel.getSubscribedMovies()
            subcribedMoviesCell.configureCell(with: subscribedMovies, delegate: self)
            return subcribedMoviesCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.sections[indexPath.section] == .AllMovies else {
            return
        }
        let movieDetailViewModel = viewModel.getMovieDetailViewModel(index: indexPath.row)
        let vc = MovieDetailViewController(viewModel: movieDetailViewModel, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - MovieDetailDelegate-
extension HomeViewController: MovieDetailViewControllerDelegate {
    func subscribeButtonPressed() {
        tableView.reload()
    }
}
//MARK: - Subscribed Movies Cell Delegate-
extension HomeViewController: SubscribedMoviesTableViewCellDelegate {
    func openMovieDetail(with index: Int) {
        let movieDetailViewModel = viewModel.getMovieDetailViewModel(index: index, subscribed: true)
        let vc = MovieDetailViewController(viewModel: movieDetailViewModel, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

