//
//  ResultsTableViewCell.swift
//  Movie Night
//
//  Created by Joe Sherratt on 08/09/2016.
//  Copyright © 2016 jsherratt. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    //-----------------------
    //MARK: Outlets
    //-----------------------
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    //-----------------------
    //MARK: View
    //----------------------
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //-----------------------
    //MARK: Extra
    //-----------------------
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
