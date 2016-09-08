//
//  Utilities.swift
//  Movie Night
//
//  Created by Joe Sherratt on 05/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

//-----------------------
//MARK: Extensions
//-----------------------
extension UIViewController {
    
    //General alert for errors etc
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) -> Void in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //Option alert for when the user taps on selection button after already making them
    func displayOptionAlert() {
        
        let alert = UIAlertController(title: "Oops", message: "You have already made your selections. Are you sure you want to do them again?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) in
            
            self.performSegueWithIdentifier("ShowGenres", sender: self)
            
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension Array where Element: Hashable {
    
    func mergeDuplicates() -> [Element: Int] {
        var result = [Element: Int]()
        
        self.forEach({ result[$0] = result[$0] ?? 0 + 1 })
        
        return result
    }
}
