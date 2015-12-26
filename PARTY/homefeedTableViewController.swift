//
//  homefeedTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 8/30/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import CoreLocation
import Parse



class homefeedTableViewController: PFQueryTableViewController, CLLocationManagerDelegate {
        
    let locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    
    @IBOutlet weak var switchstates: UISegmentedControl!
  
    @IBOutlet weak var nopartiesview: UIView!

    
 
    
var parties : NSMutableArray = NSMutableArray()
   
    
    
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
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if(locations.count != 0){
            let location = locations[0] as CLLocation
           
            currentLocation = location.coordinate
        } else {
            print("Cannot fetch your location")
        }
    }
    
   

    

    
    override func queryForTable() -> PFQuery {
    //current users followers 
        
    let queryforfollowingfriends = PFQuery(className: "Follow")
        queryforfollowingfriends.whereKey("from", equalTo:PFUser.currentUser()!)
        queryforfollowingfriends.whereKey("Type", equalTo: "Follow")
        
        //current party that friends of the user followers
    let queryforfriends = PFQuery(className: "parties")
        queryforfriends.whereKey("partyhost", matchesKey: "to", inQuery: queryforfollowingfriends)
        queryforfriends.whereKeyExists("objectId")
        
        //current user photeos
    let currentuserphotos = PFQuery(className: "parties")
        currentuserphotos.whereKey("partyhost", equalTo: PFUser.currentUser()!)
         currentuserphotos.whereKeyExists("objectId")
        
        let results = PFQuery.orQueryWithSubqueries([queryforfriends,currentuserphotos])
        results.includeKey("objectId")
        results.orderByAscending("createdAt")
    
    
      return results
      
        
    }
  



    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
      
        
    }
    //this is the function for getting the parties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.locationManager.desiredAccuracy = 1000
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
          self.navigationItem.title = "PARTY"
        self.nopartiesview.hidden = false
        
        
        let isUserLoggedIn  = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            dispatch_async(dispatch_get_main_queue()){
                self.performSegueWithIdentifier("homeview", sender: self);
            }
        }
 
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let isUserLoggedIn  = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            dispatch_async(dispatch_get_main_queue()){
            self.performSegueWithIdentifier("homeview", sender: self);
            }
        }
        

    }
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    
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
        if objects!.count == 0 {
        nopartiesview.hidden = false
        
        }else {
        nopartiesview.hidden = true
        
        }
        
        
        return objects!.count
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject? {
    var obj : PFObject? = nil
    
        if(indexPath.row < self.objects!.count){
            obj = self.objects![indexPath.row] as? PFObject
    }
    
        return obj
    }
    @IBAction func unwindToSegue(segue:UIStoryboardSegue) {
        _ = segue.sourceViewController as! newpartiesViewController
        
        
        
        
    }
        


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell
        {
        let cell : customTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! customTableViewCell
       
            
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
        
        cell.partytitle.text = object!.objectForKey("title") as? String
        
        cell.celldesc.text = object!.objectForKey("description") as? String
        
        
        cell.partycellusername.text = object!.objectForKey("username") as? String
        
            let newtime = NSDate()
            
            let time = object!.createdAt
            time!.minutesFrom(time!)
            
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
        
        return cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "partyDetail"){
                    let indexPath = self.tableView.indexPathForSelectedRow!
                    let obj = self.objects![indexPath.row] as! PFObject
                    let navVC = segue.destinationViewController as! UINavigationController
                    let detailVC = navVC.topViewController as! DetailViewViewController
                    detailVC.party = obj
            
                    
                
        
        }
    }

}
