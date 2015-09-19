//
//  registrationcontroller.swift
//  PARTY
//
//  Created by Reuben Ukah on 8/12/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit
import Foundation
import Parse

class registrationcontroller: UIViewController {
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//        
//    }
    @IBOutlet weak var emailuser: UITextField!
    
    @IBOutlet weak var passworduser: UITextField!
    
    
    @IBOutlet weak var passwordrepeat: UITextField!
    //this is registration method 
    
    
    
    
    @IBAction func textFieldEditing(sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"),forControlEvents: UIControlEvents.ValueChanged)
    
}
    @IBOutlet weak var dateTextField: UITextField!
    
    func datePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
    
    }

    @IBAction func signuppressed(sender: AnyObject) {
    //we gotta check to see if the inputs are empty
        let useremail =  emailuser.text!
        
        let userpass = passworduser.text!
        
        let userconfpass = passwordrepeat.text!
        
        //let birthday = dateTextField.text!
        
        if(useremail.isEmpty || userpass.isEmpty || userconfpass.isEmpty){
            print("Please fill in all inputs");
            
            //display alert message
            let alert = UIAlertView()
            alert.title = "PARTY"
            alert.message  = "Please fill in everything"
            alert.addButtonWithTitle("Understood")
            return;
            
        }
        if(userpass != userconfpass){
        print("Your passwords don't match")
            return;
        }
        
        
        //store data if all the conditions are passed
        
        let user = PFUser()
        user.username = useremail
        user.password = userpass
        user.email = useremail
        
        user.signUpInBackgroundWithBlock {(succeeded, error: NSError?) -> Void in
        if(error == nil){
        //Great you signed in !
            self.performSegueWithIdentifier("homeview", sender: self)
        }
    
    }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.hidesBackButton = false
        self.navigationController?.hidesBarsWhenKeyboardAppears = false
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
