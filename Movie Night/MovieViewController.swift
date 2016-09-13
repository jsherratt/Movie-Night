//
//  MovieViewController.swift
//  Movie Night
//
//  Created by Joe Sherratt on 05/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //-----------------------
    //MARK: Variables
    //-----------------------
    
    //Movie database client and sections for table view
    let movieDatabase = MovieDatabaseClient()
    var sectionsArray: [Section] = []
    
    //Selected genres from genre view controller
    var selectedGenres: [Genre] = []
    
    //Selected movies from movie view controller
    var selectedMovieArray: [Movie] = []
    var selectedCount = 0

    //-----------------------
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfSelectedItemsLabel: UILabel!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customise navigation bar
        self.navigationItem.title = "Select Movies"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(goToFirstViewController))
        
    }
    
    //ViewDidAppear because the user may go back and change genre selections
    override func viewDidAppear(animated: Bool) {
        
        //Fetch movies for selected genres
        fetchMovies()
    }
    
    //--------------------------------
    //MARK: Movie Database Functions
    //--------------------------------
    
    //Fetch all genres
    func fetchMovies() {

        var index = 0
        
        //Fetch movies for each genre id
        for id in selectedGenres {
            
            movieDatabase.fetchMoviesWithGenre(withQuery: Int(id.id)) { (result) in
                
                switch result {
                    
                case.Success(let movies):
                    
                    let sortedMoviesArray = movies.sort { $0.title < $1.title }
                    
                    //Create a section each set of movies
                    let movies = Section(title: self.selectedGenres[index].name, items: sortedMoviesArray)
                    self.sectionsArray.append(movies)
                    
                    self.tableView.reloadData()
                    
                    index += 1
                    
                case .Failure(let error as NSError):
                    
                    print(error.localizedDescription)
                    
                default:
                    break
                }
            }
        }
    }
    
    //-----------------------
    //MARK: Table View
    //-----------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return sectionsArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionsArray[section].items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MovieTableViewCell
        
        //Set the text in the cells from the data
        let movie = sectionsArray[indexPath.section].items[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = movie.releaseDate
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Stop the user from selecting more than 5 genres
        if selectedCount >= 5 {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            displayAlert("Oops", message: "You cannot select more than 5 genres")
            
        }else {
            
            //Add selected movie to selected movie array so it can be passed to another view controller
            let movie = sectionsArray[indexPath.section].items[indexPath.row]
            selectedMovieArray.append(movie)
            
            //Increase the selected count and update the label
            selectedCount += 1
            numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Removed the selected movie from the selected movie array
        let movie = sectionsArray[indexPath.section].items[indexPath.row]
        if let indexOfMovie = selectedMovieArray.indexOf({$0.title == movie.title}) {
            
            selectedMovieArray.removeAtIndex(indexOfMovie)
        }
        
        //Minus the selected count and update the label
        selectedCount -= 1
        numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //Set the title of each section
        let sortedGenres = sectionsArray.sort { $0.title < $1.title }
        
        return sortedGenres[section].title
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    func goToFirstViewController() {
        
        if selectedCount < 5 {
            
            displayAlert("Oops", message: "You must select 5 movies")
            
        }else {
            
            let firstViewController = self.navigationController?.viewControllers[0] as! ViewController
            firstViewController.selectedMovies.appendContentsOf(selectedMovieArray)
            
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    //-------------------------
    //MARK: Prepare for Segue
    //-------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
