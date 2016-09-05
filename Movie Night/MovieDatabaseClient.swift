//
//  NetworkManager.swift
//  Star Wars: The API Awakens
//
//  Created by Joe Sherratt on 14/08/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Enums
//-----------------------
enum MovieDatabase: Endpoint {
    
    case Genres
    
    var baseURL: NSURL {
        return NSURL(string: "http://api.themoviedb.org/3/")!
    }
    
    private var apiKey: String {
        
        return "06ae2257d3872f41ebdbb16eb888bd17"
    }
    
    var path: String {
        
        switch self {
        case .Genres:
            return "genre/movie/list?api_key=\(apiKey)"
        }
    }
    
    var request: NSURLRequest {
        
        let url = NSURL(string: path, relativeToURL: baseURL)!
        return NSURLRequest(URL: url)
    }
}

//-----------------------
//MARK: Classes
//-----------------------
final class MovieDatabaseClient: APIClient {
    
    let configuration: NSURLSessionConfiguration
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    init(configuration: NSURLSessionConfiguration) {
        self.configuration = configuration
    }
    
    convenience init() {
        self.init(configuration: .defaultSessionConfiguration())
    }
    
    //-----------------------
    //MARK: Genres
    //-----------------------
    func fetchGenres(completion: APIResult<[Genre]> -> Void) {
        
        let request = MovieDatabase.Genres.request
        
        fetch(request, parse: { json -> [Genre]? in
                        
            if let genres = json["genres"] as? [[String : AnyObject]] {
                                
                return genres.flatMap { genreDict in
                    
                    return try? Genre(json: genreDict)
                }
                
            }else {
                return nil
            }
            
            }, completion: completion)
    }
}