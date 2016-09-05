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
    let movieDatabase = MovieDatabaseClient()
    var genreArray: [Genre] = []
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
        
        fetchGenres()
    }
    
    //--------------------------------
    //MARK: Movie Database Functions
    //--------------------------------
    
    //Fetch all genres
    func fetchGenres() {
        
        movieDatabase.fetchGenres { (result) in
            
            switch result {
                
            case .Success(let genres):
                
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
            
            //Increase the selected count and update the label
            selectedCount += 1
            
            numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Minus the selected count and update the label
        selectedCount -= 1
        
        numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    func next() {
        
        if selectedCount == 0 {
            
            displayAlert("Oops", message: "You must select at least 1 genre")
            
        }else {
            
            performSegueWithIdentifier("ShowMovies", sender: self)
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
