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
import CoreData

class HomeViewModel {
    
    let disposeBag = DisposeBag()
 
   //MARK: -Local Storage -
    
   
    var moviesDB: BehaviorRelay<[MovieDB]> = .init(value: [])
    
    
    
    
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
    
    var sections: [Sections] {
        return self.getSubscribedMovies().isEmpty ? [.AllMovies] : Sections.allCases
    }
   
    init() {
        fetchGenres()
        self.moviesDB.accept(PersistenceManager.shared.loadMovies())
        
        
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
                    _moviesPack.movies.forEach({ [weak self] movie in
                        movie._selectedGenre = self?.genres.filter({$0.id == movie.genreIds.first}).first
                    })
                
                    self.updateMoviesDB(with: _moviesPack.movies)

                },
                
                onError: { [weak self] error in
                    debugPrint(error.localizedDescription)
                }).disposed(by: disposeBag)
    }
    
    func getSubscribedMovies() -> [MovieDB] {
        return moviesDB.value.filter({$0.subscribed})
    }
    
    func getMovie(at index: Int, subscribed: Bool? = false) -> MovieDB {
        if subscribed == true {
            return getSubscribedMovies()[index]
        } else {
            return moviesDB.value[index]
        }
        
    }
    
    func getAllMovies() -> [MovieDB] {
        return moviesDB.value
    }
    
    
    func updateMoviesDB(with newMovies: [Movie]) {
        newMovies.forEach { [weak self] movie in
            guard let movieID = movie.id else { return }
            if let _ = self?.moviesDB.value.filter({$0.id == movieID}).first {

            } else {
                PersistenceManager.shared.createMovieDB(with: movie)
            }
        }
         
        moviesDB.accept(PersistenceManager.shared.loadMovies())
        
    }

    
    func subscribeButtonPressed() {
        PersistenceManager.shared.saveMovies()
    }

}
