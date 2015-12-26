//
//  userdetailViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/18/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class userdetailViewController: UIViewController {

    
    
    @IBOutlet weak var userrequestprofileimage: UIImageView!
    @IBOutlet weak var usernamerequestprofile: UILabel!
    @IBOutlet weak var acceptrequest: UIButton!
    var acceptrequestobject : PFObject!
    
    @IBAction func cancelrequest(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let usernamerequestobject = acceptrequestobject?.objectForKey("user") as! PFUser
        usernamerequestprofile.text = usernamerequestobject.username
        
        //we need to find the profile picture of that specific request 
        //profile image
        let findpict:PFQuery = PFUser.query()!
    
        
        findpict.whereKey("objectId", equalTo: (acceptrequestobject!.objectForKey("user")?.objectId)!)
        
        findpict.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                let user: PFUser = (objects! as NSArray).lastObject as! PFUser
                
                let profileimage :PFFile = user["profileimage"] as! PFFile
                profileimage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        let image: UIImage = UIImage(data: imageData!)!
                         self.userrequestprofileimage.image = image
                    }else {
                        print(error)
                        
                    }
                }
            }
        }
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
