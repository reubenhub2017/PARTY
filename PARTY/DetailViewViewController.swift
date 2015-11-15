import UIKit
import Parse
import MapKit
import CoreLocation

class DetailViewViewController:UIViewController  {
    var currentObject: PFObject?
    
    
    @IBAction func addedpartier(sender: AnyObject) {
        party.incrementKey("attending")
        party.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                let query = PFObject(className: "Activity")
                query.setValue(self.party!.objectId, forKey: "Goingto")
                query.setValue(PFUser.currentUser(), forKey: "user")
                
                
                
                let userattending = PFUser.currentUser()
                userattending!.incrementKey("attendingnumber")
                userattending!.saveInBackground()
                
                
                query.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    
                    if error == nil {
                        print("Success")
                    }else {
                        print(error)
                        
                    }
                    
                })
                
                
            } else {
                print(error)
            }
        }
        
        
        
        let addeding = party?.objectForKey("attending") as! Int
       
        
    }
    
    
    
    var party :PFObject!
    
    var toPass : String!
    
    var partyname : String!
    
    
    @IBOutlet weak var partymap: MKMapView!
    
    @IBOutlet weak var titleofparty: UILabel!
    
    
    
    @IBOutlet weak var timecreated: UILabel!
    
   
    
    @IBOutlet weak var numberofpeople: UILabel!
    
    
    
    
    @IBAction func cancelpressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        
        //let creatoroftheparty = party?.objectForKey("partyhost") as? PFUser
        //creatoroftheparty?.username
        //timecreated.text = "Started at \(formatter.stringFromDate((party?.createdAt)!))" + "created by" + "\(creatoroftheparty)"
        
        
        
        
       
        
        
        
        let desclocation : PFGeoPoint = party.objectForKey("location") as! PFGeoPoint
        
        let latitude : CLLocationDegrees = desclocation.latitude
        let longtitude : CLLocationDegrees = desclocation.longitude
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        let location2 = CLLocation(latitude: latitude, longitude: longtitude)
     
        
        CLGeocoder().reverseGeocodeLocation(location2) { (placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                let annotation = MKPointAnnotation()
                annotation.title = self.party?.objectForKey("title") as? String
                annotation.subtitle = "\(pm.subThoroughfare! + " " + pm.thoroughfare!)"
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}