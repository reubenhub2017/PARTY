//
//  settingprofileTableView.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/4/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
class settingprofileTableView: UITableViewController {


    @IBOutlet weak var logoutlabel: UIButton!

    @IBOutlet weak var usersettingprofile: UILabel!
    @IBOutlet weak var usersettinglabel: UILabel!
    
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var emailsettingprofile: UILabel!
    
    
    @IBAction func logoutbutton(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Sign Out", message: "Are you sure you want to Sign out", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction!) in
            print("you have pressed the Cancel button");
        }
        
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) {
            (action:UIAlertAction!) in
            
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
            NSUserDefaults.standardUserDefaults().synchronize();
            
            
            PFUser.logOut()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewControllerWithIdentifier("homescreen") as UIViewController
//             self.dismissViewControllerAnimated(true, completion: nil)
//            self.presentViewController(vc, animated: true, completion: nil)
            
            self.performSegueWithIdentifier("homeview2", sender: self)
            
          
          
            
            
            
            
           
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
          
        }
        
        
        // ...
    
    }
   
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
     logoutlabel.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
    self.navigationItem.title = "SETTINGS"
        print(PFUser.currentUser()!.username!)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.usersettinglabel.text = PFUser.currentUser()!.username!
        self.emaillabel.text = PFUser.currentUser()!.email!
    print(PFUser.currentUser()?.username!)
    }
   

}
