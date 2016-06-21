//
//  usernameemailpasswordchangeTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/14/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class usernameemailpasswordchangeTableViewController: UITableViewController {

    @IBOutlet weak var usernamechange: UITextField!
    
    @IBOutlet weak var emailchange: UITextField!
    
    @IBOutlet weak var passwordchange: UITextField!
    
    
    
    @IBAction func updateemailchange(sender: AnyObject) {
    let emailtextchange = emailchange.text
    PFUser.currentUser()?.email = emailtextchange
      self.displayMessage("We updated your email, it will take a few moments to update our system!")
    PFUser.currentUser()?.saveInBackground()
    
    }
    @IBAction func updateusernamebtn(sender: AnyObject) {
        let usernametextchange = usernamechange.text
        PFUser.currentUser()?.username = usernametextchange
          self.displayMessage("We updated your username, it will take a few moments to update our system!")
        PFUser.currentUser()?.saveInBackground()
    }
    
    @IBAction func updatepassword(sender: AnyObject) {
        let passwordtextchange = passwordchange.text
        PFUser.currentUser()?.password = passwordtextchange
          self.displayMessage("We updated your password, it will take a few moments to update our system!")
        PFUser.currentUser()?.saveInBackground()
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.title = "Account Settings"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
