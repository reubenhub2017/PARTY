//
//  UserlocationTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 11/13/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class UserlocationTableViewController: PFQueryTableViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var parties : NSMutableArray = NSMutableArray()
    var currentLocation : CLLocationCoordinate2D?
    
  
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if(locations.count != 0){
            let location = locations[0] as CLLocation
           
            currentLocation = location.coordinate
        } else {
           
        }
    }


    override func queryForTable() -> PFQuery {
        //current users followers
        
      
        let query = PFQuery(className: "parties")
        if let current = currentLocation {
            query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: current.latitude, longitude: current.longitude), withinMiles: 10)
        
        
        
        
        }
        return query
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.locationManager.desiredAccuracy = 1000
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.navigationItem.title = "Explore"
        Appirater.appLaunched(true)
        Appirater.setAppId("1070877486")
        Appirater.setDaysUntilPrompt(3)
        Appirater.setUsesUntilPrompt(3)
        Appirater.setSignificantEventsUntilPrompt(-1)
        Appirater.setTimeBeforeReminding(3)
        Appirater.setDebug(false)
        
        
       

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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! customTableViewCell
        
 
        
        cell.partytitle.text = object!.objectForKey("title") as? String
        
        cell.celldesc.text = object!.objectForKey("description") as? String
        
        
        cell.partycellusername.text = object!.objectForKey("username") as? String
        
                
        //profile image
        let findpict:PFQuery = PFUser.query()!
        
        
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
        
        let newtime = NSDate()
        
        let time = object!.createdAt
        time!.minutesFrom(time!)
        
        let finaltime = newtime.offsetFrom(time!)
        
        
        cell.time.text = "\(finaltime)"
        
        
        cell.profcellimage.layer.cornerRadius = cell.profcellimage.frame.size.width/2
        cell.profcellimage.clipsToBounds = true
        cell.profcellimage.layer.masksToBounds = true
        
        cell.profcellimage.layer.borderColor = UIColor.blackColor().CGColor
        cell.profcellimage.layer.borderWidth = 1.0

        

        // Configure the cell...

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
