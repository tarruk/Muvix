//
//  MoviesPack.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//


import Foundation

class MoviesPack : Codable {
    var rating          : Double?
    var backDropPath    : String?
    var createdBy       : String?
    var description     : String?
    var id              : String?
    var language1       : String?
    var language2       : String?
    var name            : String?
    var page            : Int?
    var posterPath      : String?
    var isPublic        : Bool?
    var movies          : [Movie] = []
    var totalPages      : Int?
    var totalResults    : Int?
    
    enum CodingKeys: String, CodingKey {
        case rating          = "average_rating"
        case backDropPath    = "backdrop_path"
        case createdBy       = "created_by"
        case description     = "description"
        case id              = "id"
        case language1       = "iso_3166_1"
        case language2       = "iso_639_1"
        case name            = "name"
        case page            = "page"
        case posterPath      = "poster_path"
        case isPublic        = "public"
        case movies          = "items"
        case totalPages      = "total_pages"
        case totalResults    = "total_results"

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.rating          = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.backDropPath    = try container.decodeIfPresent(String.self, forKey: .backDropPath)
        self.createdBy       = try container.decodeIfPresent(String.self, forKey: .createdBy)
        self.description     = try container.decodeIfPresent(String.self, forKey: .description)
        self.id              = try container.decodeIfPresent(String.self, forKey: .id)
        self.language1       = try container.decodeIfPresent(String.self, forKey: .language1)
        self.language2       = try container.decodeIfPresent(String.self, forKey: .language2)
        self.name            = try container.decodeIfPresent(String.self, forKey: .name)
        self.page            = try container.decodeIfPresent(Int.self, forKey: .page)
        self.posterPath      = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.isPublic        = try container.decodeIfPresent(Bool.self, forKey: .isPublic)
        self.movies          = try container.decodeIfPresent([Movie].self, forKey: .movies) ?? []
        self.totalPages      = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        self.totalResults    = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        
    }
    
    
    
}
