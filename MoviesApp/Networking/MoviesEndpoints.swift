//
//  MoviesEndpoints.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import Alamofire

extension Request {
    
    struct GetMoviesPack: NetworkProtocol {
        var request: RequestData
        typealias ResponseType = MoviesPack
        let path = Request()
        
        init(listId: Int) {
            
            let params: [String: Any?] =  [
                "api_key"   : Keys.APIKey.rawValue
            ]

            self.request = RequestData(path: path.createPath(with: "list/\(listId)"), method: .get, parameters: params)
        }
    }
    
    
    
    
    struct GetGenres: NetworkProtocol {
        var request: RequestData
        typealias ResponseType = Genres
        let path = Request()
        
        init() {
            
            let params: [String: Any?] =  [
                "api_key"   : Keys.APIKey.rawValue
            ]
            
            self.request = RequestData(path: path.createPath(with: "genre/movie/list"), method: .get, parameters: params)
        }
        
    }
    
    
    struct GetMov: NetworkProtocol {

        var request: RequestData
        typealias ResponseType = [Movie]
        let path = Request()
        
        init(page: Int, key: String? = nil) {
            
            let params: [String: Any?] =  [
                "page"   : page,
                "key"    : key
            ]

            let headers : HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json;charset=utf-8")]
           
            self.request = RequestData(path: path.createPath(with: "list/\(page)"), method: .get, parameters: params, headers: headers)
        }
    }
}
