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
        tableView.backgroundColor = Colors.backgroundBlack
        tableViewSetup()
        setDataBridge()
        
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
    
    
    func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "PreviewHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviewHeaderTableViewCell")
        
        tableView.register(UINib(nibName: "PreviewTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviewTableViewCell")
        
        tableView.register(UINib(nibName: "SubscribedMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "SubscribedMoviesTableViewCell")
        
        
        tableView.reloadData()
    }
    
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
        let previewMovieHeader = tableView.dequeueReusableCell(withIdentifier: "PreviewHeaderTableViewCell") as! PreviewHeaderTableViewCell
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
            let previewMovieCell = tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell", for: indexPath) as! PreviewTableViewCell
            if let movie = viewModel?.movies.value[indexPath.row] {
                previewMovieCell.configureCategory(movie: movie)
            }
            return previewMovieCell
            
        case .Subscripted:
            let subcribedMoviesCell = tableView.dequeueReusableCell(withIdentifier: "SubscribedMoviesTableViewCell", for: indexPath) as! SubscribedMoviesTableViewCell
            if let movies = viewModel?.movies.value {
                subcribedMoviesCell.configureCell(with: movies)
            }
            return subcribedMoviesCell
        case .none: return UITableViewCell()
        }
        
    }
    
    
}

