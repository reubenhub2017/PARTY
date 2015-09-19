//
//  logincontrollerViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 8/12/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Foundation
import Parse

class logincontrollerViewController: UIViewController {
    //Built in function so that if the user presses the anywhere the keyboard will disappear
//     func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
      
        self.navigationItem.hidesBackButton = false
        self.navigationController?.hidesBarsWhenKeyboardAppears = false
        
        
        
//        let isUserLoggedIn =
//        NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
//        
//        if(!isUserLoggedIn)
//        {
//        self.performSegueWithIdentifier("loginview", sender: self)
//        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
       
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.whiteColor()
        
       
        
        
        
    }
    func perferredStatusBarStyle()-> UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Login in the user
    
    @IBOutlet weak var useremail: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    
    @IBAction func login(sender: AnyObject) {
        
        let email = useremail.text!;
        let password2 = userpassword.text!;
       
        //checks to see if the email or password is empty
       
        PFUser.logInWithUsernameInBackground(email, password: password2) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                self.dismissViewControllerAnimated(true, completion: nil)
                
                
            }else {
            print("could not find user")
            }
        
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
