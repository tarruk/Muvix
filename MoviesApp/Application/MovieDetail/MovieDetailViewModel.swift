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
    
    var movie: Movie
    
    var movieImageUrl   : BehaviorRelay<String?> = .init(value: nil)
    var movieTitle      : BehaviorRelay<String?> = .init(value: nil)
    var movieReleaseDate: BehaviorRelay<String?> = .init(value: nil)
    var movieOverview   : BehaviorRelay<String?> = .init(value: nil)
    var movieSubscription: BehaviorRelay<Bool>   = .init(value: false)
    
    init(movie: Movie) {
        self.movie = movie
        setData()
    }
    
    func setData() {
        movieImageUrl.accept(movie._imageURL)
        movieTitle.accept(movie.orgTitle?.capitalized)
        let releaseYear = movie.releaseDate?.components(separatedBy: "-").first
        movieReleaseDate.accept(releaseYear)
        movieOverview.accept(movie.description?.capitalized)
        movieSubscription.accept(movie._subscribed)
    }
    
    func subscribeButtonPressed() {
        self.movie._subscribed.toggle()
        self.movieSubscription.accept(movie._subscribed)
    }
    
    
}
