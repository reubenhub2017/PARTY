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
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationManager.stopUpdatingLocation()
        if(locations.count == 0){
            let location = locations[0] as! CLLocation
            print(location.coordinate)
            let currrentLocation = location.coordinate
        } else {
            print("Cannot fetch your location")
        }
    }
    
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "parties")
        if let querylocation = currentLocation {
            query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: querylocation.latitude, longitude: querylocation.longitude),withinMiles: 10)
            query.limit = 200;
            query.orderByDescending("createdAt")
        }
        else {
            query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: 37.411822, longitude: -121.941125), withinMiles: 10)
            query.limit = 200;
            query.orderByDescending("createdAt")
            print("no parties around")
            
        }
        return query
        
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        print("cannot fetch your location")
        
    }
    //this is the function for getting the parties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let isUserLoggedIn  = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegueWithIdentifier("homesegue", sender: self);
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
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        
        return cell as! UITableViewCell
}

}
