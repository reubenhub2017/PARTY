//
//  settingsViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/23/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    @IBOutlet weak var userbutton: UIButton!

    @IBOutlet weak var usernamechange: UITextField!
    
   
    @IBAction func userhchangebtn(sender: AnyObject) {
     _ = PFQuery(className: "User")
        PFUser.currentUser()?.setObject(usernamechange.text!, forKey: "username")
        PFUser.currentUser()?.saveEventually()
    
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
                
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        
        userbutton.frame = CGRectMake(100, 100, 50, 40)
        userbutton.setTitle("Change", forState: UIControlState.Normal)
      
        userbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        userbutton.backgroundColor = UIColor.clearColor()
        userbutton.layer.borderWidth = 1
        userbutton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        userbutton.layer.cornerRadius = cornerRadius
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillLayoutSubviews() {
   
        
        let border = CALayer()
        let width = CGFloat(1.22)
        border.borderColor = UIColor.whiteColor().CGColor
        
        border.frame = CGRect(x: 0, y: usernamechange.frame.size.height - width, width:  usernamechange.frame.size.width, height: usernamechange.frame.size.height)
        
        border.borderWidth = width
        usernamechange.layer.addSublayer(border)
        usernamechange.layer.masksToBounds = true
        
        
      
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
