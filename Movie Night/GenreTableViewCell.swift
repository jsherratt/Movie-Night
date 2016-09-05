//
//  CustomTableViewCell.swift
//  Movie Night
//
//  Created by Joe Sherratt on 05/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    
    //-----------------------
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    //-----------------------
    //MARK: View
    //-----------------------
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.checkmarkImage.image = selected ? UIImage(named: "selected") : UIImage(named: "unSelected")
    }

}
