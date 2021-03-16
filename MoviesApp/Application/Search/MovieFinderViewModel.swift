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
    
    var movies: [Movie] = []
    var keyword: String?
    var filteredMovies: [Movie] {
        return movies.filter {
            ($0.orgTitle?.range(of: keyword ?? "", options: .caseInsensitive) != nil || keyword == nil || keyword == "")
        }
    }
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func resetFilter() {
        self.keyword = nil
    }
    
    func getMovie(at index: Int) -> Movie {
        return filteredMovies[index]
    }
}
