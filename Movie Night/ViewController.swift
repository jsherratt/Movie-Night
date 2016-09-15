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
    @IBOutlet weak var instructionLabel: UILabel!
    
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
        
        //Instruction text for instruction label
        instructionLabel.text = "Using the preference buttons both users take turns selecting their favourite genres followed by their favourite movies.\n\n Once both users have made their selections tap the View Results button to show all the movies that were selected. An icon will be displayed on movies that were selected by both users."
        
        //Fine tune asset positioning that could not be accomplished in autolayout
        adjustAssets()
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
    
    func adjustAssets() {
        
        let height = view.frame.size.height
        
        if height == 568 {
            
            let move = CGAffineTransformMakeTranslation(-25, -60)
            let scale = CGAffineTransformMakeScale(0.85, 0.85)
            
            let move2 = CGAffineTransformMakeTranslation(25, -60)
            let scale2 = CGAffineTransformMakeScale(0.85, 0.85)
            
            leftBtn.transform = CGAffineTransformConcat(move, scale)
            rightBtn.transform = CGAffineTransformConcat(move2, scale2)
            
            instructionLabel.font = instructionLabel.font.fontWithSize(13.0)
            
        }else if height == 736 {
            
            leftBtn.transform = CGAffineTransformMakeTranslation(0, 25)
            rightBtn.transform = CGAffineTransformMakeTranslation(0, 25)

            instructionLabel.font = instructionLabel.font.fontWithSize(16.0)
        }
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

