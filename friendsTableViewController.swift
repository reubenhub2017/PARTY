//
//  friendsTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/31/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
class friendsTableViewController: PFQueryTableViewController {

    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "parties"
        self.textKey = "partytitle"
        self.pullToRefreshEnabled = true
        self.objectsPerPage = 200
    }

    override func queryForTable() -> PFQuery {
        
        let queryforfollowingfriends = PFQuery(className: "Follow")
        queryforfollowingfriends.whereKey("from", equalTo: PFUser.currentUser()!)
        queryforfollowingfriends.whereKey("Type", equalTo: "Follow")
      
        
        
     
      return queryforfollowingfriends
        
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
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject? {
        var obj : PFObject? = nil
        
        if(indexPath.row < self.objects!.count){
            obj = self.objects![indexPath.row] as? PFObject
        }
        
        return obj
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell
    {
        
        let cell : customTableViewCell = tableView.dequeueReusableCellWithIdentifier("friendcell") as! customTableViewCell
        
    
        // set up the query on the Follow table
        let query = PFQuery(className: "Follow")
        query.whereKey("from", equalTo: PFUser.currentUser()!)
        
        // execute the query
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                for o in objects {
                    // o is an entry in the Follow table
                    // to get the user, we get the object with the to key
                    let otherUse = o.objectForKey("to") as? PFUser
                    print(otherUse?.username)
                    
                    
                    cell.userfollower.text = otherUse?.username
                    
                }
            }
            if error != nil {
            print(error)
            }
        }
 

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
