//
//  profileViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 8/15/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
import Bolts

class profileViewController: UIViewController {

    @IBAction func logoutpressed(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        PFUser.logOutInBackgroundWithBlock({(error: NSError?) -> Void in
            self.performSegueWithIdentifier("homeview", sender: self)
        })
        
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
