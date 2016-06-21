//
//  AcceptedRequestTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/20/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class AcceptedRequestTableViewController: PFQueryTableViewController{
    var theuserwhogotaccepted: PFObject!
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Party"
        self.textKey = "partytitle"
        self.pullToRefreshEnabled = true
        self.objectsPerPage = 200
    }
    override func queryForTable() -> PFQuery {
       
        let query = PFQuery(className: "AcceptedRequest")
        
    
        query.whereKey("accepted", equalTo: "true")
        query.whereKey("userwhogotaccepted", equalTo: PFUser.currentUser()!)
        query.includeKey("acceptedfrom")
        
        
        let searchforpary = PFQuery(className: "parties")
        searchforpary.whereKey("partyhost", matchesKey: "acceptedfrom", inQuery: query)
        
        
        
        
        
        
      
        
        return query
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

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
        return self.objects!.count
    }
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject? {
        var obj : PFObject? = nil
        
        if(indexPath.row < self.objects!.count){
            obj = self.objects![indexPath.row] as? PFObject
        }
        
        return obj
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell {
        
        
        let cell : customTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! customTableViewCell
        
        let userstring =  object.objectForKey("acceptedfrom") as? PFUser
        let username = userstring
        theuserwhogotaccepted = username
        
        
        
        
        cell.theacceptedrequestsen.text = username!.username! + " accepted your request "
        
        cell.theacceptedrequestpix.layer.cornerRadius = cell.theacceptedrequestpix.frame.size.width/2
        cell.theacceptedrequestpix.clipsToBounds = true
        cell.theacceptedrequestpix.layer.masksToBounds = true
        
        cell.theacceptedrequestpix.layer.borderColor = UIColor.blackColor().CGColor
        cell.theacceptedrequestpix.layer.borderWidth = 1.0
        
        
        let findpict:PFQuery = PFUser.query()!
        findpict.whereKey("objectId", equalTo: (object.objectForKey("acceptedfrom")?.objectId)!)
        
        findpict.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                let user: PFUser = (objects! as NSArray).lastObject as! PFUser
                
                let profileimage :PFFile = user["profileimage"] as! PFFile
                profileimage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        let image: UIImage = UIImage(data: imageData!)!
                        cell.theacceptedrequestpix.image = image
                    }else {
                        print(error)
                        
                    }
                }
            }
        }


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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "partyDetail"){
            let indexPath = self.tableView.indexPathForSelectedRow!
            let obj = self.objects![indexPath.row] as! PFObject
            let navVC = segue.destinationViewController as! UINavigationController
            let detailVC = navVC.topViewController as! DetailViewViewController
            detailVC.currentforuser = obj
            
            
            
            
        }
    }

}
