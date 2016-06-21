import UIKit
import Parse
import MapKit
import CoreLocation

class DetailViewViewController:UIViewController  {
    var currentObject: PFObject?
    var currentforuser : PFObject!
    var party :PFObject!
    
    @IBOutlet weak var privateviewcontainer: UIView!
    var toPass : String!
    
    var partyname : String!
    
    
    
    
    @IBAction func addedpartier(sender: AnyObject) {
        party.incrementKey("attending")
        let requestoption = party.objectForKey("privacy") as! Bool
        
        party.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                let query = PFObject(className: "Activity")
                query.setValue(self.party!.objectId, forKey: "Goingto")
                query.setValue(PFUser.currentUser(), forKey: "user")
                query.setObject(self.party.objectForKey("partyhost")!, forKey: "partyhost")
                
                if requestoption == true {
                    query.setValue(true, forKey: "request")
                    self.displayMessage("The host has to accept your request, goodluck!")
                    
                    let pushQuery = PFInstallation.query()!
                    pushQuery.whereKey("user", equalTo:self.party.objectForKey("partyhost")!) //friend is a PFUser object
                    
                    
                    let push = PFPush()
                    push.setQuery(pushQuery)
                    push.setMessage("\(PFUser.currentUser()!.username!) wants to go to your party ")
                    push.sendPushInBackground()
             
                
                }
                else {
                query.setValue(false, forKey: "request")
                    self.displayMessage("Have fun tonight!")
                
                }

                let userattending = PFUser.currentUser()
                userattending!.incrementKey("attendingnumber")
                userattending!.saveInBackground()
                
                
                query.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    
                    if error == nil {
                        
                    }else {
                        
                    }
                    
                })
                
                
            } else {
               
            }
        }
        
        
        
        _ = party?.objectForKey("attending") as! Int
        
       
        
    }

    
    @IBOutlet weak var partymap: MKMapView!
    
    @IBOutlet weak var titleofparty: UILabel!
    
    
    
    @IBOutlet weak var timecreated: UILabel!
    
   
    
    @IBOutlet weak var numberofpeople: UILabel!
    
    
    
    
    @IBAction func cancelpressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

        
        

    override func viewDidLoad() {
        super.viewDidLoad()
        //we need the current user 
        
        let partyprivatecontainer = party.objectForKey("privacy") as! Bool
        
        if partyprivatecontainer == false {
        privateviewcontainer.hidden = true
        
        }
        
        var query: PFQuery = PFQuery(className: "AcceptedRequest")
        
        query.whereKey("userwhogotaccepted", equalTo: PFUser.currentUser()!)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.privateviewcontainer.hidden = true
                     
                    }
                }
            }
        }
    
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let creatoroftheparty = party!.objectForKey("partyhost") as! PFUser
       
        timecreated.text = "Started at \(formatter.stringFromDate((party!.createdAt)!)) " + "created by" + " \(creatoroftheparty.username!)"

        let desclocation : PFGeoPoint = party.objectForKey("location") as! PFGeoPoint
        
        let latitude : CLLocationDegrees = desclocation.latitude
        let longtitude : CLLocationDegrees = desclocation.longitude
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        let location2 = CLLocation(latitude: latitude, longitude: longtitude)
     
        let regionRadius: CLLocationDistance = 1000
        
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 3.0, regionRadius * 3.0)
            self.partymap.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location2)
        
        
        CLGeocoder().reverseGeocodeLocation(location2) { (placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                let annotation = MKPointAnnotation()
                 _ = MKCoordinateSpanMake(latitude, longtitude)
                
                
                
                annotation.title = self.party?.objectForKey("title") as? String
                annotation.subtitle = "\(pm.subThoroughfare! + " " + pm.thoroughfare! + " " + pm.locality! + " " + pm.postalCode!)"
                annotation.coordinate = location
                
                self.partymap.addAnnotation(annotation)
            
            }else {
                print("Problem with the data recieved from Geocoder")
            }
        }
        
        titleofparty.text = party?.objectForKey("title") as? String
        
        self.navigationItem.title = party?.objectForKey("title") as? String
        
        let addeding = party?.objectForKey("attending") as! Int
        
        if(addeding == 0){
            self.numberofpeople.text = "None is coming to this party"
            
        }
        if(addeding == 1){
            self.numberofpeople.text = " A person is coming to this party"
            
        }
            
        else {
            self.numberofpeople.text = "\(addeding)" + " people are coming attending this party"
            }
    
    }
    
    
    func displayMessage(theMesssage:String)
    {
        // Display alert message with confirmation.
        let myAlert = UIAlertController(title:"Party Notification", message:theMesssage, preferredStyle: UIAlertControllerStyle.Alert);let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion:nil);
        }
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
    }
    }
