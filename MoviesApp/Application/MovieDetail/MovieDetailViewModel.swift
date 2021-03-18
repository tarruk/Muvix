//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Tarek on 14/03/2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MovieDetailViewModel {
    
    var movie: MovieDB
    
    var movieImageUrl   : BehaviorRelay<String?> = .init(value: nil)
    var movieTitle      : BehaviorRelay<String?> = .init(value: nil)
    var movieReleaseDate: BehaviorRelay<String?> = .init(value: nil)
    var movieOverview   : BehaviorRelay<String?> = .init(value: nil)
    var movieSubscription: BehaviorRelay<Bool>   = .init(value: false)
    
    init(movie: MovieDB) {
        self.movie = movie
        setData()
    }
    
    deinit {
        debugPrint("Closing MovieDetailViewModel")
    }
    
    func setData() {
        movieImageUrl.accept(movie.posterPath)
        movieTitle.accept(movie.title?.capitalized)
        movieReleaseDate.accept(movie.year)
        movieOverview.accept(movie.overview?.capitalized)
        movieSubscription.accept(movie.subscribed)
    }
    
    func subscribeButtonPressed() {
        self.movie.subscribed.toggle()
        self.movieSubscription.accept(movie.subscribed)
        PersistenceManager.shared.saveMovies()
    }
    
    
}
