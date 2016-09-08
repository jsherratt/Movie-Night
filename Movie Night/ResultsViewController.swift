//
//  ResultsViewController.swift
//  Movie Night
//
//  Created by Joe Sherratt on 06/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:TODO - Remove duplicates from movie array and display that that movie was choosen by both users
    
    //-----------------------
    //MARK: Variables
    //-----------------------
    var movies: [Movie] = []
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

    }
    
    //-----------------------
    //MARK: Table View
    //-----------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ResultsTableViewCell
        
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = movie.releaseDate
        
        if indexPath.row % 2 == 0 {
            
            cell.cellImage.backgroundColor = UIColor(red: 155/255.0, green: 212/255.0, blue: 235/255.0, alpha: 1.0)
            
        }else {
            cell.cellImage.backgroundColor = UIColor(red: 181/255.0, green: 227/255.0, blue: 245/255.0, alpha: 1.0)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedMovie = movies[indexPath.row]
        
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
