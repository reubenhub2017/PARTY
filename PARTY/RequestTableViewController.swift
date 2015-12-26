//
//  RequestTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/20/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class RequestTableViewController: PFQueryTableViewController{
    
    var cell : customTableViewCell!
    var requesteduser: PFObject!
    var party: String!
    
    
    
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
        
        let searchforuser = PFQuery(className: "Activity")
        searchforuser.whereKey("user", notEqualTo: PFUser.currentUser()!)
        searchforuser.whereKey("partyhost", equalTo: PFUser.currentUser()!)
        
        searchforuser.whereKey("request", equalTo: true)
        searchforuser.includeKey("user")
        
        
        let searchforpary = PFQuery(className: "parties")
        searchforpary.whereKey("objectId", matchesKey: "fromparty", inQuery: searchforuser)
        
        
        
        
        return searchforuser
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return self.objects!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell {
         let cell : customTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! customTableViewCell
        
        let userstring =  object.objectForKey("user") as? PFUser
        let username = userstring
        requesteduser = username

        let partyrequest = object.objectForKey("request") as? Bool
        party = object.objectForKey("Goingto") as! String
        
        
        if partyrequest == true {
            cell.therequestsentence.text = username!.username!  + " wants to go to your party"
         
        }
        cell.therequestcellimage.layer.cornerRadius = cell.therequestcellimage.frame.size.width/2
        cell.therequestcellimage.clipsToBounds = true
        cell.therequestcellimage.layer.masksToBounds = true
        
        cell.therequestcellimage.layer.borderColor = UIColor.blackColor().CGColor
        cell.therequestcellimage.layer.borderWidth = 1.0
        
        //we need to find the profile picture
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
                        cell.therequestcellimage.image = image
                    }else {
                        print(error)
                        
                    }
                }
            }
        }

        
        
        return cell
    }
    
    @IBAction func acceptbtnpressed(sender: AnyObject) {
        let otheruser = requesteduser
        
        let setnewvalue = PFObject(className: "AcceptedRequest")
        setnewvalue.setValue("true", forKey: "accepted")
        setnewvalue.setValue(PFUser.currentUser(), forKey: "acceptedfrom")
        setnewvalue.setValue(otheruser, forKey: "userwhogotaccepted")
        setnewvalue.setValue(party, forKey: "fromparty")
        setnewvalue.saveInBackground()
        print("success")
    
    
    
    }
    
    
    
    
    
    

}
