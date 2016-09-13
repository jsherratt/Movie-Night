//
//  ResultsViewController.swift
//  Movie Night
//
//  Created by Joe Sherratt on 06/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    //-----------------------
    //MARK: Variables
    //-----------------------
    
    //Array of selected movies from both users
    var movies: [Movie] = []
    
    //Dictionay without duplicates if the users happen to choose the same movie. Shows the movie and how many times the movie was selected
    var moviesWithoutDuplicatesDict: [Movie : Int] = [:]
    
    //Array of movies using the keys from the moviesWithoutDuplicatesDict dictionary
    var movieArray: [Movie] = []
    
    //Selected movie to show in the detail view controller
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
        
        //Remove extra empty cells from the footer view
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Add movies to the moviesWithoutDuplicatesDict dictionary and show how many times a movie was selected
        for movie in movies {
            
            moviesWithoutDuplicatesDict[movie] = (moviesWithoutDuplicatesDict[movie] ?? 0) + 1
        }
        
        //Sort the movies by title
        let sortedMovies = moviesWithoutDuplicatesDict.sort { $0.0.title < $1.0.title }
        
        //Prints the title of the selects movies and how many times they were selected
        for (key, value) in sortedMovies {
            
            print("\(key.title) has been selected \(value) times")
        }
        
        //Array of movies using the keys from the moviesWithoutDuplicatesDict dictionary
        movieArray = Array(self.moviesWithoutDuplicatesDict.keys)
        
    }
    
    //-----------------------
    //MARK: Table View
    //-----------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Number of rows is equal to the number of items in the moviesWithoutDuplicatesDict dictionary
        return moviesWithoutDuplicatesDict.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ResultsTableViewCell
        
        //Sort the movie array my title
        let sortedMovieArray = movieArray.sort { $0.title < $1.title }
        
        //Set the text in the cells from the movie data
        let movie = sortedMovieArray[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = movie.releaseDate
        
        //Change the cell image of each odd row. If two users happened to have selected the same movie unhide a "two user icon" i.e. moviesWithoutDuplicatesDict value is > 2
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
        
        //Sort movie array by title
        let sortedMovieArray = movieArray.sort { $0.title < $1.title }
        
        //Set the selected movie to the movie at the row selected
        selectedMovie = sortedMovieArray[indexPath.row]
        
        //Segeue to the detail view of the selected movie
        performSegueWithIdentifier("ShowDetail", sender: self)
    }
    
    //-------------------------
    //MARK: Prepare for Segue
    //-------------------------
    
    //Pass the selected movie to the results detail view
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
