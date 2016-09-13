//
//  ViewController.swift
//  Movie Night
//
//  Created by Joe Sherratt on 04/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //-----------------------
    //MARK: Variables
    //-----------------------
    
    //Array of movies after both users have made their selections. This will passed to the results view after
    var selectedMovies: [Movie] = []
    var hasNetworkError = false
    
    //-----------------------
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var viewResultsBtn: UIButton!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customise navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .Plain, target: self, action: #selector(clearSelections))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: nil)
        
        //Round corners of view results button
        viewResultsBtn.layer.cornerRadius = 5
        viewResultsBtn.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //Reset selections if there was a network error
        if hasNetworkError == true {

            clearSelections()
        }
    }
    
    //-----------------------
    //MARK: Button Actions
    //-----------------------
    
    //If the left or right user has already made selections, display an alert notifying them. They can also repeat their selections. Otherwise move to the genre view
    @IBAction func leftBtnTapped(sender: UIButton) {
        
        if leftBtn.selected == true {
            
            displayOptionAlert()
            
        }else {
            performSegueWithIdentifier("ShowGenres", sender: self)
            leftBtn.selected = true
        }
    }
    
    @IBAction func rightBtnTapped(sender: UIButton) {
        
        if rightBtn.selected == true {
            
            displayOptionAlert()
            
        }else {
            performSegueWithIdentifier("ShowGenres", sender: self)
            rightBtn.selected = true
        }
    }
    
    //If both users have made selections move to the results view to show the movies
    @IBAction func viewResults(sender: UIButton) {
        
        if leftBtn.selected == true && rightBtn.selected == true {
            
            performSegueWithIdentifier("ShowResults", sender: self)
            
        }else {
            displayAlert("Oops", message: "Both users must make movie selections")
        }
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    
    //Clear user selections and reset buttons
    func clearSelections() {
        
        hasNetworkError = false
        
        leftBtn.selected = false
        rightBtn.selected = false
        
        selectedMovies.removeAll()
    }
    
    //-------------------------
    //MARK: Prepare for Segue
    //-------------------------
    
    //Pass the selected movies to the results view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowResults" {
            
            if let vc = segue.destinationViewController as? ResultsViewController {
                
                let sortedSelectedMovies = selectedMovies.sort { $0.title < $1.title }
                vc.movies = sortedSelectedMovies
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

