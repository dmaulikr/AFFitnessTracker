//
//  FitnessTableViewCell.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 4/26/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class FitnessTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var waistLabel: UILabel!
    @IBOutlet weak var situpsLabel: UILabel!
    @IBOutlet weak var pushupsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}