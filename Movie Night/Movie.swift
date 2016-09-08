//
//  Movie.swift
//  Movie Night
//
//  Created by Joe Sherratt on 05/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

//-----------------------
//MARK: Structs
//-----------------------
struct Movie {
    
    var title: String
    var releaseDate: String
    var id: Int
    
    init(json: [String : AnyObject]) throws {
        
        guard let title = json["title"] as? String, let releaseDate = json["release_date"] as? String, let id = json["id"] as? Int else { throw Error.MissingInfo }
        
        self.title = title
        self.releaseDate = releaseDate
        self.id = id
    }
}

struct Section {
    
    var title : String
    var items : [Movie]
    
    init(title: String, items : [Movie]) {
        
        self.title = title
        self.items = items
    }
}

struct ImageLoader {
    func requestImageDownloadForURL(url: String, completion: (image: UIImage?) -> Void) {
        if let url = NSURL(string: "https://image.tmdb.org/t/p/w92\(url)") {
            if let data = NSData(contentsOfURL: url) {
                if let image = UIImage(data: data) {
                    completion(image: image)
                }
            }
        }
    }
}
