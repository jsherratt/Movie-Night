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
        
        fetchImageForMovie()
        
        overviewTextLabel.text = movie?.overview
    }
    
    func fetchImageForMovie() {
        
        imageLoader.requestImageDownloadForURL(url: movie?.posterImageURL) { image in
            
            if let image = image {
                
                self.movieImage.image = image
            }
        }
        
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
