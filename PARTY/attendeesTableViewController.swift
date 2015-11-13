//
//  attendeesTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/1/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class attendeesTableViewController: PFQueryTableViewController {

     var user2: PFUser!
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Activity"
        self.textKey = "partytitle"
        self.pullToRefreshEnabled = true
        self.objectsPerPage = 200
    }
    override func queryForTable() -> PFQuery {
        
        let searchforuser = PFQuery(className: "Activity")
        searchforuser.whereKey("user", notEqualTo: PFUser.currentUser()!)
        
        
        let searchforpary = PFQuery(className: "parties")
        searchforpary.whereKey("objectId", matchesKey: "Goingto", inQuery: searchforuser)
    
       
        
        return searchforuser
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell
    {
        let cell : customTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! customTableViewCell
        
     
       
        let userstring =  object.objectForKey("user") as? PFUser
        let username = userstring
        cell.sentence.text = username!.username!  + "is going to your party"
       
        
        
       
    
    
        

        // Configure the cell...

                return cell
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

    
    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//        
//        
//        let searchforparty = PFQuery(className: "parties")
//        searchforparty.whereKey("partyhost", equalTo: (PFUser.currentUser()?.objectId)!)
//        searchforparty.includeKey("objectId")
//        
//        let searchforpeople = PFQuery(className: "Activity")
//        searchforpeople.whereKey("Goingto", matchesKey: "objectId", inQuery: searchforpeople)
//        
//        
//        
//    
//    
//    
//    
//    
//    
//    }
    

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
