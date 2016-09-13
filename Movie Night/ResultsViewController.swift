//
//  ResultsViewController.swift
//  Movie Night
//
//  Created by Joe Sherratt on 06/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:TODO - Display that a movie was choosen by both users
    
    //-----------------------
    //MARK: Variables
    //-----------------------
    var movies: [Movie] = []
    var moviesWithoutDuplicatesDict: [Movie : Int] = [:]
    var movieArray: [Movie] = []
    var selectedMovie: Movie?
    
    //-----------------------
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var tableView: UITableView!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customise navigation bar
        self.navigationItem.title = "Results"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        for movie in movies {
            
            moviesWithoutDuplicatesDict[movie] = (moviesWithoutDuplicatesDict[movie] ?? 0) + 1
        }
        
        let sortedMovies = moviesWithoutDuplicatesDict.sort { $0.0.title < $1.0.title }
        
        for (key, value) in sortedMovies {
            
            print("\(key.title) has been selected \(value) times")
        }
        
        movieArray = Array(self.moviesWithoutDuplicatesDict.keys)
    }
    
    //-----------------------
    //MARK: Table View
    //-----------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesWithoutDuplicatesDict.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ResultsTableViewCell
        
        let sortedMovieArray = movieArray.sort { $0.title < $1.title }
        
        let movie = sortedMovieArray[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = movie.releaseDate
        
        if indexPath.row % 2 == 0 {
            
            cell.cellImage.backgroundColor = UIColor(red: 155/255.0, green: 212/255.0, blue: 235/255.0, alpha: 1.0)
            
            if moviesWithoutDuplicatesDict[sortedMovieArray[indexPath.row]] > 1 {
                
                cell.doubleSelectionImage.hidden = false
                
            }else {
                
                cell.doubleSelectionImage.hidden = true
            }
            
        }else {
            
            cell.cellImage.backgroundColor = UIColor(red: 181/255.0, green: 227/255.0, blue: 245/255.0, alpha: 1.0)
            
            if moviesWithoutDuplicatesDict[sortedMovieArray[indexPath.row]] > 1 {
                
                cell.doubleSelectionImage.hidden = false
                
            }else {
                
                cell.doubleSelectionImage.hidden = true
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sortedMovieArray = movieArray.sort { $0.title < $1.title }
        
        selectedMovie = sortedMovieArray[indexPath.row]
        
        performSegueWithIdentifier("ShowDetail", sender: self)
    }
    
    //-------------------------
    //MARK: Prepare for Segue
    //-------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            
            if let vc = segue.destinationViewController as? ResultsDetailViewController {
                
                vc.movie = selectedMovie
            }
        }
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
