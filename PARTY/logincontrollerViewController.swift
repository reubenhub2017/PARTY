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

class logincontrollerViewController: UIViewController, UITextFieldDelegate {
    //Built in function so that if the user presses the anywhere the keyboard will disappear
//     func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//        
//    }
    
    let someTextField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someTextField.delegate = self
        self.navigationController?.navigationBar.hidden = false
      
        self.navigationItem.hidesBackButton = false
        self.navigationController?.hidesBarsWhenKeyboardAppears = false
        
        
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
   
    func displayMessage(theMesssage:String)
    {
        // Display alert message with confirmation.
        let myAlert = UIAlertController(title:"Party Notification", message:theMesssage, preferredStyle: UIAlertControllerStyle.Alert);let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion:nil);
        }
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    
    @IBAction func cancelbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    @IBOutlet weak var useremail: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    
    @IBOutlet weak var emailrequest: UITextField!
   
    @IBAction func resetfunction(sender: AnyObject) {
        PFUser.requestPasswordResetForEmailInBackground(emailrequest.text!) { (success:Bool?, error:NSError?) -> Void in
            if(error == nil){
            self.displayMessage("Great!, check your email for a link from us!")
            }
            if error != nil {
            self.displayMessage("oops! Try again!")
            
            }
        }
        }
    
    
    
    
    
    @IBAction func login(sender: AnyObject) {
        
        let email = useremail.text!;
        let password2 = userpassword.text!;
       
        //checks to see if the email or password is empty
       
        PFUser.logInWithUsernameInBackground(email, password: password2) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                self.performSegueWithIdentifier("testsegue", sender: self)
                
             
                
            }else {
                let alertController = UIAlertController(title: "Sorry try again", message: "Check to see if your username/password is correct or if you have internet connection", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    // ...
                }
                alertController.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // ...
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
            
            
            }
        
        }
    
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        useremail.resignFirstResponder()
        userpassword.resignFirstResponder()
        emailrequest.resignFirstResponder()
        
        return true
        
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
