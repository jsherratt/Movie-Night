//
//  GenreViewController.swift
//  Movie Night
//
//  Created by Joe Sherratt on 05/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //-----------------------
    //MARK: Variables
    //-----------------------
    
    //Movie database to make api calls
    let movieDatabase = MovieDatabaseClient()
    
    //Array of genres
    var genreArray: [Genre] = []
    
    //Array for the selected genres
    var selectedGenreArray: [Genre] = []
    
    //Count for number of selected genres
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
        self.navigationItem.title = "Select Genres"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(next))
        
        //Add notification observer for the showAlert function
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showAlert), name: "NetworkAlert", object: nil)
        
        //Fetch all genres
        fetchGenres()
        
    }
    
    //--------------------------------
    //MARK: Movie Database Functions
    //--------------------------------
    
    //Fetch all available genres
    func fetchGenres() {
        
        movieDatabase.fetchGenres { (result) in
            
            switch result {
                
            case .Success(let genres):
                
                //Assign the genres to the genre array and reload the table view
                self.genreArray = genres
                self.tableView.reloadData()
                
            case .Failure(let error as NSError):
                print(error.localizedDescription)
                
            default:
                break
            }
        }
    }
    
    //-----------------------
    //MARK: Table View
    //-----------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Number of rows is equal to the number of genres
        return genreArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! GenreTableViewCell
        
        //Set the text in the cells from the data
        let genre = genreArray[indexPath.row]
        cell.genreLabel.text = genre.name
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Stop the user from selecting more than 5 genres
        if selectedCount >= 5 {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            displayAlert("Oops", message: "You cannot select more than 5 genres")
            
        }else {
            
            //Add selected genre to selected genre array so it can be passed to another view controller
            let genre = genreArray[indexPath.row]
            selectedGenreArray.append(genre)
            
            //Increase the selected count and update the label
            selectedCount += 1
            numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Removed the selected genre from the selected genre array
        let genre = genreArray[indexPath.row]
        if let indexOfGenre = selectedGenreArray.indexOf({$0.name == genre.name}) {
            
            selectedGenreArray.removeAtIndex(indexOfGenre)
        }
        
        //Minus the selected count and update the label
        selectedCount -= 1
        numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    
    //Move to the movies view if 5 genres have been selected
    func next() {
        
        if selectedCount < 5 {
            
            displayAlert("Oops", message: "You must select 5 genres")
            
        }else {
            
            performSegueWithIdentifier("ShowMovies", sender: self)
        }
    }
    
    //Show alert when there is no network connection
    func showAlert() {
        
        displayNetworkAlert("Error", message: "Check the network connection and try again")
        
        //Set hasNetworkError to true
        let firstViewController = self.navigationController?.viewControllers[0] as! ViewController
        firstViewController.hasNetworkError = true
    }
    
    //Deinit the notification observer
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NetworkAlert", object: nil)
    }
    
    //-------------------------
    //MARK: Prepare for Segue
    //-------------------------
    
    //Pass the selected genres to the movie view 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowMovies" {
            
            if let vc = segue.destinationViewController as? MovieViewController {
                
                let sortedGenreArray = selectedGenreArray.sort { $0.name < $1.name }
                
                vc.selectedGenres = sortedGenreArray
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
