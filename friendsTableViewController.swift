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
     var unuserfollowbutton : PFObject!
    var cell: customTableViewCell!
  
    
    
    
 

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
        queryforfollowingfriends.includeKey("to")
      
        
        
     
      return queryforfollowingfriends
        
    }
    
        
        
        
        
        
        
        
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
        
    
       
  
                let otherUse = object.objectForKey("to") as? PFUser
        
                    unuserfollowbutton = otherUse
                    
                    cell.userfollower.text = otherUse?.username
                  

           
                    
                    
                    
                    
                   
        
 

        // Configure the cell...

        return cell
    }
    
  
    @IBAction func deletefriend(sender: AnyObject) {
        let unfollow = PFQuery(className: "Follow")
        let otheruser = unuserfollowbutton
        unfollow.whereKey("to", equalTo: otheruser)
  
      
        
       
      
        
        unfollow.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
            for object in objects! {
                
                object.deleteEventually()
                print("success")
                self.tableView.reloadData()
            }
            if error != nil {
            print(error)
            
            }
        })
    
    
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
