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
    
    case Movies
    
    var baseURL: String {
        return "http://api.themoviedb.org/3/"
    }
    
    private var apiKey: String {
        
        return "06ae2257d3872f41ebdbb16eb888bd17"
        
    }
    
    func createUrl(withQuery query: Int?) -> NSURL {
        
        switch self {
            
        case .Genres:
            
            return NSURL(string: baseURL + "genre/movie/list?api_key=\(apiKey)")!
            
        case .Movies:
            
            return NSURL(string: baseURL + "genre/\(query!))/movies?api_key=\(apiKey)" )!
        }
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
        
        let request = NSURLRequest(URL: MovieDatabase.Genres.createUrl(withQuery: nil))
        
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
    
    //-----------------------
    //MARK: Movies
    //-----------------------
    func fetchMoviesWithGenre(withQuery query: Int?, completion: APIResult<[Movie]> -> Void) {
        
        let request = NSURLRequest(URL: MovieDatabase.Movies.createUrl(withQuery: query))
        
        fetch(request, parse: { json -> [Movie]? in
            
            if let movies = json["results"] as? [[String : AnyObject]] {
                
                return movies.flatMap { movieDict in
                    
                    return try? Movie(json: movieDict)
                }
                
            }else {
                return nil
            }
            
            }, completion: completion)
    }
}
