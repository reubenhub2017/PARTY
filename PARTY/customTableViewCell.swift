//
//  customTableViewCell.swift
//  PARTY
//
//  Created by Reuben Ukah on 9/30/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse

class customTableViewCell: PFTableViewCell {

    @IBOutlet weak var partytitle: UILabel!
    @IBOutlet weak var partycelldescription: UILabel!
    @IBOutlet weak var partycellusername: UILabel!
    @IBOutlet weak var attendeespic: UIImageView!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var followlabel: UIButton!
    @IBOutlet weak var celldesc: UITextView!
    
    @IBOutlet weak var userfollower: UILabel!
    @IBOutlet weak var unfollowpressed: UIButton!

   
    @IBOutlet weak var userprogileimage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    
    
    @IBOutlet weak var profcellimage: UIImageView!
    
    @IBOutlet weak var acceptedrequest: UIButton!
    @IBOutlet weak var sentence: UILabel!
    @IBOutlet weak var addedtime: UILabel!
    
    
    
    //the  accepted request cells
    @IBOutlet weak var theacceptedrequestpix: UIImageView!
    
    @IBOutlet weak var theacceptedrequestsen: UILabel!
    
    //the request cells
    
    @IBOutlet weak var therequestcellimage: UIImageView!
    
    @IBOutlet weak var therequestsentence: UILabel!
    
    @IBOutlet weak var acceptedbutton: UIButton!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
