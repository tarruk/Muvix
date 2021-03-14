//
//  Movie.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation


class Movie: Codable {
    var adults          : Bool?
    var backDropPath    : String?
    var genreIds        : [Int] = []
    var id              : Int?
    var mediaType       : String?
    var orgLanguage     : String?
    var orgTitle        : String?
    var description     : String?
    var popularity      : Double?
    var posterPath      : String?
    var releaseDate     : String?
    var title           : String?
    var video           : Bool?
    var voteAverage     : Double?
    var voteCount       : Int?
    var _selectedGenre  : MovieGenre?
    var _imageURL: String? {
        if let image = self.posterPath {
            return "https://image.tmdb.org/t/p/w500/\(image)"
        } else {
            return nil
        }
    }
               

    enum CodingKeys: String, CodingKey {
        case adults          = "adult"
        case backDropPath    = "backdrop_path"
        case genreIds        = "genre_ids"
        case id              = "id"
        case mediaType       = "media_type"
        case orgLanguage     = "original_language"
        case orgTitle        = "original_title"
        case description     = "overview"
        case popularity      = "popularity"
        case posterPath      = "poster_path"
        case releaseDate     = "release_date"
        case title           = "title"
        case video           = "video"
        case voteAverage     = "vote_average"
        case voteCount       = "vote_count"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.adults          = try container.decodeIfPresent(Bool.self, forKey: .adults )
        self.backDropPath    = try container.decodeIfPresent(String.self, forKey: .backDropPath )
        self.genreIds        = try container.decodeIfPresent([Int].self, forKey: .genreIds ) ?? []
        self.id              = try container.decodeIfPresent(Int.self, forKey: .id )
        self.mediaType       = try container.decodeIfPresent(String.self, forKey: .mediaType )
        self.orgLanguage     = try container.decodeIfPresent(String.self, forKey: .orgLanguage )
        self.orgTitle        = try container.decodeIfPresent(String.self, forKey: .orgTitle )
        self.description     = try container.decodeIfPresent(String.self, forKey: .description )
        self.popularity      = try container.decodeIfPresent(Double.self, forKey: .popularity )
        self.posterPath      = try container.decodeIfPresent(String.self, forKey: .posterPath )
        self.releaseDate     = try container.decodeIfPresent(String.self, forKey: .releaseDate )
        self.title           = try container.decodeIfPresent(String.self, forKey: .title )
        self.video           = try container.decodeIfPresent(Bool.self, forKey: .video )
        self.voteAverage     = try container.decodeIfPresent(Double.self, forKey: .voteAverage )
        self.voteCount       = try container.decodeIfPresent(Int.self, forKey: .voteCount )
        
    }
    
}
