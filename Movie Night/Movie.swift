//
//  Movie.swift
//  Movie Night
//
//  Created by Joe Sherratt on 05/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Structs
//-----------------------
struct Movie {
    
    var title: String
    var releaseDate: String
    
    init(json: [String : AnyObject]) throws {
        
        guard let title = json["title"] as? String, let releaseDate = json["release_date"] as? String else { throw Error.MissingInfo }
        
        self.title = title
        self.releaseDate = releaseDate
    }
}