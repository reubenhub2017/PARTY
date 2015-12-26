//
//  FirstViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 6/28/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit
import Foundation
import Parse

class FirstViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        
        let isUserLoggedIn  = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        
        if(isUserLoggedIn)
        {
            self.performSegueWithIdentifier("backtohome", sender: self)
            
            
        }
        
        
}
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
        
        let isUserLoggedIn  = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        
        if(isUserLoggedIn)
        {
            
           self.performSegueWithIdentifier("backtohome", sender: self)
            
        }
    }
    
    
}