//
//  ResultsDetailViewController.swift
//  Movie Night
//
//  Created by Joe Sherratt on 08/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class ResultsDetailViewController: UIViewController {
    
    //-----------------------
    //MARK: Variables
    //-----------------------
    var movie: Movie?
    var imageLoader = ImageLoader()
    
    //-----------------------
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var overviewTextLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Round corners of done button
        doneBtn.layer.cornerRadius = 5
        doneBtn.layer.masksToBounds = true
        
        //Round corners of movie image
        movieImage.layer.borderWidth = 3
        movieImage.layer.borderColor = UIColor(red: 175/255.0, green: 66/255.0, blue: 70/255.0, alpha: 1.0).CGColor
        movieImage.layer.masksToBounds = true
        
        //Add notification observer for the showAlert function
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showAlert), name: "NetworkAlert", object: nil)
        
        //Fetch image for movie
        fetchImageForMovie()
        
        //Set text of overview text label with movie overview
        if let overview = movie?.overview {
            
            let fontAttribute = [NSFontAttributeName: UIFont.systemFontOfSize(17.0)]
            let overviewString = NSMutableAttributedString(string: "Overview\n\n", attributes: fontAttribute)
            let overviewTextStringAttribute = NSAttributedString(string: "\(overview)")
            
            overviewString.appendAttributedString(overviewTextStringAttribute)
            
            overviewTextLabel.attributedText = overviewString
            
        }else {
            overviewTextLabel.text = "Overview\n\n No overview available"
        }
    }
    
    //--------------------------------
    //MARK: Movie Database Functions
    //--------------------------------
    
    //Fetch the poster image for the movie
    func fetchImageForMovie() {
        
        imageLoader.requestImageDownloadForURL(url: movie?.posterImageURL) { image in
            
            if let image = image {
                
                self.movieImage.image = image
            }
        }
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    
    //Show alert when there is no network connection
    func showAlert() {
        
        displayNetworkAlert("Error", message: "Check the network connection and try again")
    }
    
    //Deinit the notification observer
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "NetworkAlert", object: nil)
    }
    
    //-----------------------
    //MARK: Button Actions
    //-----------------------
    @IBAction func backToMenu(sender: UIButton) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
