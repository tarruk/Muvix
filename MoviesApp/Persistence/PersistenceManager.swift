//
//  PersistenceManager.swift
//  MoviesApp
//
//  Created by Tarek on 17/03/2021.
//

import Foundation
import UIKit
import CoreData

class PersistenceManager {
    
    
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let shared = PersistenceManager()
    
    
    private init() {
        
    }
    
    func save() {
        saveMovies()
        NotificationCenter.default.post(name: .updateSubscribedMovies, object: nil)
    }
    
    func saveMovies() {
       do {
           try context.save()
       } catch {
           print("Error saving context \(error)")
       }
        
    
    }
    
    func createMovieDB(with movie: Movie) {
        if let _ = loadMovies().filter({$0.id == movie.id ?? -1}).first {
            
        } else {
            let movieDB = MovieDB(context: context)
            movieDB.id          = Int64(movie.id ?? 0)
            movieDB.title       = movie.orgTitle
            movieDB.overview    = movie.description
            movieDB.posterPath  = movie._imageURL
            movieDB.subscribed  = false
            movieDB.year        = movie._year
            movieDB.selectedGenre = movie._selectedGenre?.name
        }
        saveMovies()
        
    }
    
    
    func loadMovies(with request: NSFetchRequest<MovieDB> = MovieDB.fetchRequest()) -> [MovieDB] {
        do {
            let movies = try context.fetch(request)
            return movies
        } catch {
            return []
            print("Error fetching data from context \(error)")
        }
    }
}
