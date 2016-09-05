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
    let movieDatabase = MovieDatabaseClient()
    var movieArray: [Movie] = []
    var selectedMovies: [Movie] = []
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
        self.navigationItem.hidesBackButton = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(goToFirstViewController))
        
        fetchMovies()
    }
    
    //--------------------------------
    //MARK: Movie Database Functions
    //--------------------------------
    
    //Fetch all genres
    func fetchMovies() {
        
        
        
    }
    
    //-----------------------
    //MARK: Table View
    //-----------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MovieTableViewCell
        
        //Set the text in the cells from the data
        let movie = movieArray[indexPath.row]
        cell.titleLabel.text = movie.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MovieTableViewCell
        
        //Stop the user from selecting more than 5 genres
        if selectedCount >= 5 {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            displayAlert("Oops", message: "You cannot select more than 5 genres")
            
        }else {
            
            cell.checkmarkImage.image = UIImage(named: "selected")
            
            selectedCount += 1
            
            numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MovieTableViewCell
        
        //Deselect a selected genre
        cell.checkmarkImage.image = UIImage(named: "unSelected")
        
        selectedCount -= 1
        
        numberOfSelectedItemsLabel.text = "\(selectedCount) of 5 selected"
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    func goToFirstViewController() {
        
        let firstViewController = self.navigationController?.viewControllers[0] as! ViewController
        firstViewController.selectedMovies = selectedMovies
        self.navigationController?.popToRootViewControllerAnimated(true)
        
//        if selectedCount == 0 {
//            
//            displayAlert("Oops", message: "You must select at least 1 movie")
//            
//        }else {
//            
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
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
