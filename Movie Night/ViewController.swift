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
    var selectedMovies: [Movie] = []
    
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
    
    //Test to see if selectedMovieArray gets passed back
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        print(selectedMovies)
    }
    
    //-----------------------
    //MARK: Button Actions
    //-----------------------
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
    
    @IBAction func viewResults(sender: UIButton) {
        
        if leftBtn.selected == true && rightBtn.selected == true {
            
            performSegueWithIdentifier("ShowResults", sender: self)
            
        }else {
            displayAlert("Oops", message: "Both users must make selections")
        }
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    func clearSelections() {
        
        leftBtn.selected = false
        rightBtn.selected = false
    }
    
    //-------------------------
    //MARK: Prepare for Segue
    //-------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowResults" {
            
            if let vc = segue.destinationViewController as? ResultsViewController {
                
                vc.movies = selectedMovies
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

