//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewModel {
    
    let disposeBag = DisposeBag()
 
   
    
    
    
    enum Sections: CaseIterable {
        case Subscripted
        case AllMovies
        func name()->String {
            switch self {
            case .AllMovies:
                return "todas".uppercased()
            case .Subscripted:
                return "Suscriptas".uppercased()
            }
        }
        
        func index()->Int {
            switch self {
            case .AllMovies:
                return 0
            case .Subscripted:
                return 1
            }
        }
        
        
    }
    var listId: Int = 0
    var moviesPack: BehaviorRelay<MoviesPack?> = .init(value: nil)
    var genres: [MovieGenre] = [] {
        didSet {
            getNewPage()
        }
    }
    var movies: BehaviorRelay<[Movie]> = .init(value: [])
    let sections = Sections.allCases
    
    init() {
        fetchGenres()
    }
    
    
    
    
    private func fetchGenres() {
        Request
            .GetGenres()
            .rx_dispatch()
            .subscribe(
                onNext: { [weak self] genres in
                    self?.genres = genres.genres
                },
                onError: { [weak self] error in
                    debugPrint(error.localizedDescription)
                }).disposed(by: disposeBag)
    }
    
    func getNewPage() {
        guard listId != -1 else {return}
        listId += 1
        fetchMovies()
    }
    
    private func fetchMovies(){
        Request
            .GetMoviesPack(listId: listId)
            .rx_dispatch()
            .subscribe(
                onNext: { [weak self] _moviesPack in
                    guard let self = self else {return}
                    
                    if _moviesPack.movies.isEmpty {
                        self.listId = -1
                        return
                    }
                    _moviesPack.movies.forEach({ movie in
                        movie._selectedGenre = self.genres.filter({$0.id == movie.genreIds.first}).first
                    })
                
                    let newMovies = (self.listId == 1) ? _moviesPack.movies : (self.movies.value + _moviesPack.movies)
                    
                    self.movies.accept(newMovies)
                    
                },
                
                onError: { [weak self] error in
                    debugPrint(error.localizedDescription)
                }).disposed(by: disposeBag)
    }
    
    func getViewModel(index: Int) -> MovieDetailViewModel {
        return MovieDetailViewModel(movie: movies.value[index])
    }
    
    
    
}
