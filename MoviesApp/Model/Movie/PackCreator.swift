//
//  PackCreator.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation

struct PackCreator: Codable {
    var gravatarHash: String?
    var id          : String?
    var name        : String?
    var userName    : String?
    
    enum CodingKeys: String, CodingKey {
        case gravatarHash = "gravatar_hash"
        case id           = "id"
        case name         = "name"
        case userName     = "username"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.gravatarHash = try container.decodeIfPresent(String.self, forKey: .gravatarHash)
        self.id           = try container.decodeIfPresent(String.self, forKey: .id)
        self.name         = try container.decodeIfPresent(String.self, forKey: .name)
        self.userName     = try container.decodeIfPresent(String.self, forKey: .userName)
    }
}
