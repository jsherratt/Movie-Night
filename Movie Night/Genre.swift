//
//  Genre.swift
//  Movie Night
//
//  Created by Joe Sherratt on 05/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import Foundation

//-----------------------
//MARK: Enum
//-----------------------
enum Error: ErrorType {
    
    case MissingInfo
}

//-----------------------
//MARK: Structs
//-----------------------
struct Genre {
    
    var id: String
    var name: String
    
    init(json: [String : AnyObject]) throws {
        
        guard let id = json["id"] as? Int, let name = json["name"] as? String else { throw Error.MissingInfo }
        
        self.id = String(id)
        self.name = name
    }
}