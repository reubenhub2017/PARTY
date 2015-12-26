//
//  attendeesTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/1/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse

class attendeesTableViewController: PFQueryTableViewController {

    @IBOutlet weak var open: UIBarButtonItem!
     var user2: PFUser!
     var therequesteduser : PFObject!
    var cell : customTableViewCell!

    
    
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Activity"
        self.textKey = "Goingto"
        self.pullToRefreshEnabled = true
        self.objectsPerPage = 50
    }
    
    
    override func queryForTable() -> PFQuery {
        
        let searchforuser = PFQuery(className: "Activity")
        searchforuser.whereKey("partyhost", equalTo: PFUser.currentUser()!)
        searchforuser.includeKey("user")
        
        
        
        
        let searchforpary = PFQuery(className: "parties")
        searchforpary.whereKey("objectId", matchesKey: "Goingto", inQuery: searchforuser)
        
       
        
        return searchforuser
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
   

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
      
        let cell : customTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! customTableViewCell
        
     
        let userstring =  object.objectForKey("user") as? PFUser
        let username = userstring
        therequesteduser = username
        
        let partyrequest = object.objectForKey("request") as? Bool
        if partyrequest == true {
        cell.sentence.text = username!.username!  + " is going to your party"
            
            
            
            cell.attendeespic.layer.cornerRadius = cell.attendeespic.frame.size.width/2
            cell.attendeespic.clipsToBounds = true
            cell.attendeespic.layer.masksToBounds = true
            
            cell.attendeespic.layer.borderColor = UIColor.blackColor().CGColor
            cell.attendeespic.layer.borderWidth = 1.0
    
            
        }
        
        
      
    
        
        
       
        
        //profile image
        let findpict:PFQuery = PFUser.query()!
        //let parta : PFObject = self.parties.objectAtIndex(indexPath.row) as! PFObject
        
        findpict.whereKey("objectId", equalTo: (object.objectForKey("user")?.objectId)!)
        
        findpict.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                let user: PFUser = (objects! as NSArray).lastObject as! PFUser
                
                let profileimage :PFFile = user["profileimage"] as! PFFile
                profileimage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        let image: UIImage = UIImage(data: imageData!)!
                        cell.attendeespic.image = image
                    }else {
                        print(error)
                        
                    }
                }
            }
        }
    
    
                
        
        return cell
    }
  


    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "acceptrequest"){
            let indexPath = self.tableView.indexPathForSelectedRow!
            let obj = self.objects![indexPath.row] as! PFObject
            let navVC = segue.destinationViewController as! UINavigationController
            let detailVC = navVC.topViewController as! userdetailViewController
            detailVC.acceptrequestobject = obj
            
            
            
            
        }
    }
    @IBAction func acceptedrequest(sender: AnyObject) {
        //thePFUSER new 
        let otheruser = therequesteduser
        let setnewvalue = PFObject(className: "Activity")
        setnewvalue.setValue("false", forKey: "request")
        setnewvalue.setValue(otheruser, forKey: "user")
        otheruser.saveInBackground()
        print("success")
        
        
    }
}
