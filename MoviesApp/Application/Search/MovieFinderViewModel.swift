//
//  MovieFinderViewModel.swift
//  MoviesApp
//
//  Created by Tarek on 15/03/2021.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa


class MovieFinderViewModel {
    
    var movies: [MovieDB] = []
    var keyword: String?
    
    var filteredMovies: [MovieDB] {
        return movies.filter {
            ($0.title?.range(of: keyword ?? "", options: .caseInsensitive) != nil || keyword == nil || keyword == "")
        }
    }
    
    init(movies: [MovieDB]) {
        self.movies = movies
    }
    
    func resetFilter() {
        self.keyword = nil
    }
    
    func getMovie(at index: Int) -> MovieDB {
        return filteredMovies[index]
    }
    
    func subscribeButtonPressed() {
        PersistenceManager.shared.saveMovies()
    }
}
