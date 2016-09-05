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
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customise navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .Plain, target: self, action: #selector(clearSelections))
    }
    
    //-----------------------
    //MARK: Button Actions
    //-----------------------
    @IBAction func leftBtnTapped(sender: UIButton) {
        
        //sender.selected = !sender.selected
    }
    
    @IBAction func rightBtnTapped(sender: UIButton) {
        
        //sender.selected = !sender.selected
    }
    
    //-----------------------
    //MARK: Functions
    //-----------------------
    func clearSelections() {
        
        leftBtn.selected = false
        rightBtn.selected = false
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

