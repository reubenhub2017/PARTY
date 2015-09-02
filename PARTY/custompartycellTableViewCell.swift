//
//  custompartycellTableViewCell.swift
//  PARTY
//
//  Created by Reuben Ukah on 9/1/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class custompartycellTableViewCell: UITableViewCell {

    @IBOutlet weak var partyDesc: UILabel!
    @IBOutlet weak var partyTitle: UILabel!
    @IBOutlet weak var timePost: UILabel!
    
    @IBOutlet weak var people: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
