//
//  profileTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/3/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class profileTableViewController: UITableViewController {

    
    @IBOutlet weak var pimage: UIImageView!
   
    @IBOutlet weak var addtocontacts: UIButton!

    @IBOutlet weak var pname: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
    pimage.layer.cornerRadius = self.pimage.frame.size.width/2
    pimage.clipsToBounds = true
    pimage.layer.masksToBounds = true
        
    pimage.layer.borderColor = UIColor.blackColor().CGColor
    pimage.layer.borderWidth = 3.0
        
        
      
    
        
        if let userPicture = PFUser.currentUser()!["profileimage"] as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    self.pimage.image = UIImage(data:imageData!)
                }
            }
        }
            
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
                navigationItem.title =  "PROFILE"
        //pname.text! = PFUser.currentUser()!.username!
    }
    
    @IBOutlet weak var hostnumber: UILabel!
    @IBOutlet weak var attendednumber: UILabel!
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.title =  "PROFILE"
        pname.text! = PFUser.currentUser()!.username!
        
        
        let hostdetail : PFQuery = PFUser.query()!
        hostdetail.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!) {
            (object: PFObject?, error: NSError?) -> Void in
            
            
            if error == nil  {
                
                
                let host = object?.objectForKey("hostednumber") as! Int
                let attend = object?.objectForKey("attendingnumber") as! Int
                
                self.hostnumber.text = "\(host)"
                self.attendednumber.text = "\(attend)"
                
                print(host)
                
            } else {
                print(error)
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
}
