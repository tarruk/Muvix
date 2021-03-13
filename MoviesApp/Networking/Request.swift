//
//  Request.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import Alamofire


enum Keys: String {
    case APIKey = "208ca80d1e219453796a7f9792d16776"
}

struct Request {
    
    var basePath = "https://api.themoviedb.org/3/"
    
    func createPath(with finalPath: String) -> String {
       
        return basePath + finalPath
    }

}

