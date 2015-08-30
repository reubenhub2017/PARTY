//
//  homeViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 8/13/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
import Bolts

class homeViewController: UITabBarController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
        //background of the Tab bar
        UITabBar.appearance().barTintColor = UIColor(red: 0.6, green: 0.1, blue: 0.1, alpha: 1)
        //background of the Tab bar item 
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        //we need the white item color
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        
        
        let isUserLoggedIn  = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegueWithIdentifier("homeview", sender: self);
        }
        
        
        
       
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
