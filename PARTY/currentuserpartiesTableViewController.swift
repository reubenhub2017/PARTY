//
//  currentuserpartiesTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/26/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class currentuserpartiesTableViewController: PFQueryTableViewController{
   var thepartytobedeleted : PFObject!
    var searchparty: [PFUser] = [PFUser]()
    
    @IBAction func cancelbtnpressed(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    
    }
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject? {
        var obj : PFObject? = nil
        
        if(indexPath.row < self.objects!.count){
            obj = self.objects![indexPath.row] as? PFObject
        }
        
        return obj
    }

    
    
    @IBAction func deletetrashbtn(sender: AnyObject) {
        let alertController = UIAlertController(title: "Are you sure", message: "Once you delete your party, it will be gone forever", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            print(action)
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Delete", style: .Destructive) { (action) in
            let delete = PFQuery(className: "parties")
            let otherparty = self.thepartytobedeleted
            delete.whereKey("partyhost", equalTo: otherparty)
            
            
            
            
            
            
            delete.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                for object in objects! {
                    
                    object.deleteEventually()
                    self.tableView.reloadData()
                }
                if error != nil {
                    print(error)
                    
                }
            })
    
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    
    
    
    
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Party"
        self.textKey = "partytitle"
        self.pullToRefreshEnabled = true
        self.objectsPerPage = 200
    }
    
    
    override func queryForTable() -> PFQuery {
        
        //current user photeos
        let currentuserphotos = PFQuery(className: "parties")
        currentuserphotos.whereKey("partyhost", equalTo: PFUser.currentUser()!)
        currentuserphotos.whereKeyExists("objectId")
        return currentuserphotos
        
        
    }
    //This is for the actionsheet script for destroying the uiactionsheet
    

    
    
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

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell {
        let cell : customTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! customTableViewCell
        
        
        cell.partytitle.alpha = 0
        cell.profcellimage.alpha = 0
        cell.celldesc.alpha = 0
        cell.partycellusername.alpha = 0
        cell.profcellimage.alpha = 0
        cell.time.alpha = 0
        
        UIView.animateWithDuration(0.5, animations: {
            cell.partytitle.alpha = 1
            cell.profcellimage.alpha = 1
            cell.celldesc.alpha = 1
            cell.partycellusername.alpha = 1
            cell.profcellimage.alpha = 1
            cell.time.alpha = 1
            
        })
        
        let party = object!.objectForKey("partyhost") as! PFUser
        thepartytobedeleted = party
        
        
        
        
        
        cell.partytitle.text = object!.objectForKey("title") as? String
        
        cell.celldesc.text = object!.objectForKey("description") as? String
        
        
        cell.partycellusername.text = object!.objectForKey("username") as? String
        
        let newtime = NSDate()
        
        let time = object!.createdAt
        _ = time!.minutesFrom(time!)
        
        let finaltime = newtime.offsetFrom(time!)
        
        
        cell.time.text = "\(finaltime)"
        
        
        //profile image
        let findpict:PFQuery = PFUser.query()!
        //let parta : PFObject = self.parties.objectAtIndex(indexPath.row) as! PFObject
        
        findpict.whereKey("objectId", equalTo: (object.objectForKey("partyhost")!.objectId)!!)
        
        findpict.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                let user: PFUser = (objects! as NSArray).lastObject as! PFUser
                
                let profileimage :PFFile = user["profileimage"] as! PFFile
                profileimage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        let image: UIImage = UIImage(data: imageData!)!
                        cell.profcellimage.image = image
                    }else {
                        print(error)
                        
                    }
                }
            }
            
            
        }
        
        cell.profcellimage.layer.cornerRadius = cell.profcellimage.frame.size.width/2
        cell.profcellimage.clipsToBounds = true
        cell.profcellimage.layer.masksToBounds = true
        
        cell.profcellimage.layer.borderColor = UIColor.blackColor().CGColor
        cell.profcellimage.layer.borderWidth = 1.0
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
