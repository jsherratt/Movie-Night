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
struct Movie: Hashable {
    
    var title: String
    var releaseDate: String
    var id: Int
    var overview: String
    var posterImageURL: NSURL?
    
    //Conform to protocol hasable
    var hashValue: Int {
        return self.id
    }
    
    init(json: [String : AnyObject]) throws {
        
        guard let title = json["title"] as? String, let releaseDate = json["release_date"] as? String, let id = json["id"] as? Int, let overview = json["overview"] as? String ,let posterImageURL = json["poster_path"] as? String else { throw Error.MissingInfo }
        
        let dateFormatter = NSDateFormatter()
        
        self.title = title
        self.releaseDate = dateFormatter.convertDate(dateString: releaseDate)
        self.id = id
        self.overview = overview
        
        if let imageURL = NSURL(string: "https://image.tmdb.org/t/p/w92\(posterImageURL)") {
            self.posterImageURL = imageURL
        } else {
            self.posterImageURL = nil
        }
    }
}

//Struct for fetching the image from a url
struct ImageLoader {
    func requestImageDownloadForURL(url url: NSURL?, completion: (image: UIImage?) -> Void) {
        if let url = url {
            if let data = NSData(contentsOfURL: url) {
                if let image = UIImage(data: data) {
                    completion(image: image)
                }
            }
        }
    }
}

//Conform to protocol hasable
func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
}

//Struct to model a section for UITableView in the movie view controller
struct Section {
    
    var title : String
    var items : [Movie]
    
    init(title: String, items : [Movie]) {
        
        self.title = title
        self.items = items
    }
}
