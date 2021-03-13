//
//  MovieGenre.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation

struct MovieGenre: Codable {
    var id  : Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id     = "id"
        case name   = "name"
    }
}

struct Genres: Codable {
    var genres: [MovieGenre] = []
    
}
